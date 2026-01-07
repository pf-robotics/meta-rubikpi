# PFR Software Update Infrastructure
# Equivalent to running ansible-bootstrap update.yaml

SUMMARY = "PFR software update infrastructure"
DESCRIPTION = "Scripts and systemd services for software update"
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

    # Install scripts to /usr/share/pfr/bin/ (OSTree compatible)
    install -d ${D}${datadir}/pfr/bin
    install -m 0755 ${UPDATE_FILES}/inotify-sw-updater.sh ${D}${datadir}/pfr/bin/
    install -m 0755 ${UPDATE_FILES}/run-sw-update.sh ${D}${datadir}/pfr/bin/
    install -m 0755 ${UPDATE_FILES}/usb-update-api-server.py ${D}${datadir}/pfr/bin/

    # Fix paths in scripts for OSTree compatibility (/opt/pfr/bin -> /usr/share/pfr/bin)
    sed -i 's|/opt/pfr/bin|${datadir}/pfr/bin|g' ${D}${datadir}/pfr/bin/inotify-sw-updater.sh
    sed -i 's|/opt/pfr/bin|${datadir}/pfr/bin|g' ${D}${datadir}/pfr/bin/run-sw-update.sh

    # Install systemd services
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${UPDATE_FILES}/pfr-inotify-sw-updater.service ${D}${systemd_system_unitdir}/
    install -m 0644 ${UPDATE_FILES}/pfr-usb-update-api-server.service ${D}${systemd_system_unitdir}/

    # Fix paths in systemd services for OSTree compatibility
    sed -i 's|/opt/pfr/bin|${datadir}/pfr/bin|g' ${D}${systemd_system_unitdir}/pfr-inotify-sw-updater.service
    sed -i 's|/opt/pfr/bin|${datadir}/pfr/bin|g' ${D}${systemd_system_unitdir}/pfr-usb-update-api-server.service
}

# Note: USB automount is already provided by usb-scripts-automount package
FILES:${PN} = "\
    ${datadir}/pfr/bin \
    ${systemd_system_unitdir} \
"
