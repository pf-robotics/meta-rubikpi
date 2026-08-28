# PFR Software Update Infrastructure
# Equivalent to running ansible-bootstrap update.yaml
# Includes: update role + usb-automount role

SUMMARY = "PFR software update infrastructure"
DESCRIPTION = "Scripts and systemd services for software update and USB automount"
LICENSE = "CLOSED"

# Source from sr01 repository (synced via repo)
# TOPDIR is build-qcom-wayland, so ../sr01 reaches the sr01 directory
SR01_PATH ?= "${TOPDIR}/../sr01"

SRC_URI = ""
S = "${WORKDIR}"

inherit systemd

SYSTEMD_SERVICE:${PN} = "\
    pfr-inotify-sw-updater.service \
"
SYSTEMD_AUTO_ENABLE = "enable"

RDEPENDS:${PN} = "bash inotify-tools"

do_fetch[noexec] = "1"
do_unpack[noexec] = "1"

# SRC_URI is empty and do_install copies straight out of the sr01 tree, so
# nothing in the task signature would otherwise change when those files do.
# Without this, updating e.g. the RPMC binaries in sr01 while the recipe stays
# untouched lets an sstate hit silently ship the old files into the image.
do_install[file-checksums] += "\
    ${SR01_PATH}/host/ansible-ostree/roles/update/files/inotify-sw-updater.sh:True \
    ${SR01_PATH}/host/ansible-ostree/roles/update/files/run-sw-update.sh:True \
    ${SR01_PATH}/host/ansible-ostree/roles/update/files/fb-progress.py:True \
    ${SR01_PATH}/host/ansible-ostree/roles/update/files/fb_draw.py:True \
    ${SR01_PATH}/host/ansible-ostree/roles/update/files/pfr-inotify-sw-updater.service:True \
    ${SR01_PATH}/host/ansible-ostree/roles/update/files/rpmc_fwupdate:False \
    ${SR01_PATH}/host/ansible-ostree/roles/update/files/rpmc_reboot_request:False \
    ${SR01_PATH}/host/ansible-ostree/roles/usb-automount/files/usbstorage-mount.sh:True \
    ${SR01_PATH}/host/ansible-ostree/roles/usb-automount/files/usbstorage-mount@.service:True \
    ${SR01_PATH}/host/ansible-ostree/roles/usb-automount/files/90-usbstorage-mount.rules:True \
"

do_install() {
    if [ ! -d "${SR01_PATH}/host/ansible-ostree/roles/update" ]; then
        bbfatal "SR01_PATH is not set correctly. Set SR01_PATH in local.conf"
    fi

    UPDATE_FILES="${SR01_PATH}/host/ansible-ostree/roles/update/files"
    USBMOUNT_FILES="${SR01_PATH}/host/ansible-ostree/roles/usb-automount/files"

    # ========== update role ==========
    # Install scripts to /usr/share/pfr/bin/ (OSTree compatible)
    install -d ${D}${datadir}/pfr/bin
    install -m 0755 ${UPDATE_FILES}/inotify-sw-updater.sh ${D}${datadir}/pfr/bin/
    install -m 0755 ${UPDATE_FILES}/run-sw-update.sh ${D}${datadir}/pfr/bin/
    # Required by inotify-sw-updater.sh to decrypt encrypted SFS archives;
    # it looks for this next to itself (SCRIPT_PATH), so keep them together.
    install -m 0755 ${UPDATE_FILES}/decrypt-sw-update-archive.sh ${D}${datadir}/pfr/bin/
    install -m 0755 ${UPDATE_FILES}/fb-progress.py ${D}${datadir}/pfr/bin/
    install -m 0644 ${UPDATE_FILES}/fb_draw.py ${D}${datadir}/pfr/bin/

    # Eevee RPMC host tools. run-sw-update.sh resolves them next to itself
    # (RPMC_FWUPDATE / RPMC_REBOOT_REQUEST go through the /opt/pfr/bin ->
    # ${datadir}/pfr/bin rewrite below), so they must land in the same directory
    # as the scripts. Without them the first OTA applied to a freshly flashed
    # image dies at 15% with
    #   RPMC firmware update tool is not executable: .../rpmc_fwupdate
    # because the update archive carries rpmc_firmware/ while the running rootfs
    # has no updater tool: the sr01 ansible update role installs these, and that
    # role never runs on a Yocto-built image.
    #
    # They are aarch64 binaries generated into the sr01 tree (gitignored there);
    # qlipfr's pfr-build.sh builds them before invoking bitbake.
    #
    # rpmc_led_indication is deliberately NOT installed: its mere presence flips
    # inotify-sw-updater.sh into eevee RPMC LED mode (use_rpmc_led), and
    # indicate_start then fails the whole update at 0% when the RPMC board does
    # not answer on /dev/ttyHS8 - which is the case for CPU-board-only setup on
    # the line.
    for tool in rpmc_fwupdate rpmc_reboot_request; do
        if [ ! -x "${UPDATE_FILES}/$tool" ] || [ ! -s "${UPDATE_FILES}/$tool" ]; then
            bbfatal "Eevee RPMC host tool is missing: ${UPDATE_FILES}/$tool - build it from the sr01 tree first (qlipfr's pfr-build.sh does this automatically): cd <workspace>/sr01 && ./tools/build.py register-binfmt-misc && ./tools/build.py run --container hardware --aarch64 -- python3 <workspace>/sr01/tools/build_host_artifacts.py build $tool --output <workspace>/sr01/host/ansible-ostree/roles/update/files/$tool"
        fi
        install -m 0755 "${UPDATE_FILES}/$tool" ${D}${datadir}/pfr/bin/
    done

    # Fix paths in scripts for OSTree compatibility (/opt/pfr/bin -> /usr/share/pfr/bin)
    sed -i 's|/opt/pfr/bin|${datadir}/pfr/bin|g' ${D}${datadir}/pfr/bin/inotify-sw-updater.sh
    sed -i 's|/opt/pfr/bin|${datadir}/pfr/bin|g' ${D}${datadir}/pfr/bin/run-sw-update.sh

    # Install systemd services
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${UPDATE_FILES}/pfr-inotify-sw-updater.service ${D}${systemd_system_unitdir}/

    # Fix paths in systemd services for OSTree compatibility
    sed -i 's|/opt/pfr/bin|${datadir}/pfr/bin|g' ${D}${systemd_system_unitdir}/pfr-inotify-sw-updater.service

    # ========== usb-automount role ==========
    # Install USB mount script to /usr/bin/
    install -d ${D}${bindir}
    install -m 0755 ${USBMOUNT_FILES}/usbstorage-mount.sh ${D}${bindir}/

    # Install systemd service template
    install -m 0644 ${USBMOUNT_FILES}/usbstorage-mount@.service ${D}${systemd_system_unitdir}/

    # Install udev rules
    install -d ${D}${sysconfdir}/udev/rules.d
    install -m 0644 ${USBMOUNT_FILES}/90-usbstorage-mount.rules ${D}${sysconfdir}/udev/rules.d/
}

# The eevee RPMC tools are prebuilt outside bitbake (static aarch64 ELFs built
# from sr01 sources in a throwaway staging directory), so they carry neither our
# LDFLAGS nor reproducible build paths.
INSANE_SKIP:${PN} += "ldflags buildpaths"
INSANE_SKIP:${PN}-dbg += "buildpaths"

FILES:${PN} = "\
    ${datadir}/pfr/bin \
    ${bindir}/usbstorage-mount.sh \
    ${systemd_system_unitdir} \
    ${sysconfdir}/udev/rules.d \
"
