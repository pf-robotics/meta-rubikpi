SUMMARY = "Install Ubuntu Image for qcom linux"
DESCRIPTION = "Add systemd services to auto mount ubuntu image"
LICENSE = "CLOSED"

SRC_URI += "\
    file://mount_ubuntu.sh \
    file://unmount_ubuntu.sh \
    file://kill_ubuntu.sh \
    file://mount-ubuntu.service \
"

FILES:${PN} += "\
    ${bindir}/*.sh \
    /etc/systemd/system/mount-ubuntu.service \
    /etc/systemd/system/multi-user.target.wants/mount-ubuntu.service \
    /root/ubuntu24.img \
"

do_install[nostamp] = "1" # do not cache the result, run each time
do_install() {
    # Install the scripts
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/*.sh ${D}${bindir}/

    # Install the systemd service
    install -d ${D}/etc/systemd/system/
    install -m 0644 ${WORKDIR}/mount-ubuntu.service ${D}/etc/systemd/system/

    # Enable the service
    install -d ${D}/etc/systemd/system/multi-user.target.wants
    ln -sf /etc/systemd/system/mount-ubuntu.service ${D}/etc/systemd/system/multi-user.target.wants/mount-ubuntu.service

    # install mini_ubuntu image
    install -d ${D}/root
    cp ${TOPDIR}/../mini_ubuntu24.img ${D}/root/ubuntu24.img
    if [ $(stat -c%s "${D}/root/ubuntu24.img") -lt 1048576 ]; then
        echo "Oh no! The installed ubuntu24.img is too small... Please check the source image."
        exit 1
    fi
}