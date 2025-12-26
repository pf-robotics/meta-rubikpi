# PFR Software Update Infrastructure
# Equivalent to running ansible-bootstrap update.yaml

SUMMARY = "PFR software update and USB automount infrastructure"
DESCRIPTION = "Scripts, systemd services, and udev rules for software update and USB automount"
LICENSE = "CLOSED"

# Source from sr01 repository (synced via repo)
# TOPDIR is build-qcom-wayland, so ../sr01 reaches the sr01 directory
SR01_PATH ?= "${TOPDIR}/../sr01"

SRC_URI = ""
S = "${WORKDIR}"

inherit systemd

SYSTEMD_SERVICE:${PN} = "\
    pfr-inotify-sw-updater.service \
    pfr-usb-update-api-server.service \
"
SYSTEMD_AUTO_ENABLE = "enable"

RDEPENDS:${PN} = "python3 bash inotify-tools"

do_fetch[noexec] = "1"
do_unpack[noexec] = "1"

do_install() {
    if [ ! -d "${SR01_PATH}/host/ansible-ostree/roles/update" ]; then
        bbfatal "SR01_PATH is not set correctly. Set SR01_PATH in local.conf"
    fi

    UPDATE_FILES="${SR01_PATH}/host/ansible-ostree/roles/update/files"
    USB_FILES="${SR01_PATH}/host/ansible-ostree/roles/usb-automount/files"

    # === update role ===
    # Install scripts to /opt/pfr/bin/
    install -d ${D}/opt/pfr/bin
    install -m 0755 ${UPDATE_FILES}/inotify-sw-updater.sh ${D}/opt/pfr/bin/
    install -m 0755 ${UPDATE_FILES}/run-sw-update.sh ${D}/opt/pfr/bin/
    install -m 0755 ${UPDATE_FILES}/usb-update-api-server.py ${D}/opt/pfr/bin/

    # Install systemd services
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${UPDATE_FILES}/pfr-inotify-sw-updater.service ${D}${systemd_system_unitdir}/
    install -m 0644 ${UPDATE_FILES}/pfr-usb-update-api-server.service ${D}${systemd_system_unitdir}/

    # === usb-automount role ===
    # Install USB mount script
    install -d ${D}${bindir}
    install -m 0755 ${USB_FILES}/usbstorage-mount.sh ${D}${bindir}/

    # Install systemd service template
    install -m 0644 ${USB_FILES}/usbstorage-mount@.service ${D}${systemd_system_unitdir}/

    # Install udev rules
    install -d ${D}${sysconfdir}/udev/rules.d
    install -m 0644 ${USB_FILES}/10-usbstorage-mount.rules ${D}${sysconfdir}/udev/rules.d/
}

FILES:${PN} = "\
    /opt/pfr/bin \
    ${bindir}/usbstorage-mount.sh \
    ${systemd_system_unitdir} \
    ${sysconfdir}/udev/rules.d \
"
