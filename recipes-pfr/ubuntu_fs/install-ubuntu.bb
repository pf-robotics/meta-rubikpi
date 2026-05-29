SUMMARY = "Install Ubuntu Image for qcom linux"
DESCRIPTION = "Add systemd services to auto mount ubuntu image"
LICENSE = "CLOSED"

SRC_URI += "\
    file://mount_ubuntu.sh \
    file://unmount_ubuntu.sh \
    file://kill_ubuntu.sh \
    file://mount-ubuntu.service \
"

do_install() {
    # Install the scripts
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/*.sh ${D}${bindir}/

    # Install the systemd service
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/mount-ubuntu.service ${D}${systemd_system_unitdir}/

    # Enable the service
    install -d ${D}${systemd_system_unitdir}/multi-user.target.wants
    ln -sf /etc/systemd/system/mount-ubuntu.service ${D}${systemd_system_unitdir}/multi-user.target.wants/mount-ubuntu.service

    # install mini_ubuntu image
    # install -d ${D}/usr/share/pfr
    # cp ${TOPDIR}/../mini_ubuntu24.img ${D}/usr/share/pfr/ubuntu24.img
}