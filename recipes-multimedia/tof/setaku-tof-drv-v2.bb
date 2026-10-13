inherit module

DESCRIPTION = "Setaku ToF Sensor Driver v2.0"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/${LICENSE};md5=801f80980d171dd6425610833a22dbe6"

LOCAL_DRV_SRC = "${TOPDIR}/../src/tof_cam_drv2"
S = "${WORKDIR}/tof_cam_drv2"

# do not cache
do_unpack[nostamp] = "1"
do_unpack[cleandirs] = "${S}"
do_unpack() {
    install -d ${S}
    cp -aL ${LOCAL_DRV_SRC}/. ${S}/
}

RPROVIDES:${PN} += "kernel-module-setaku-tof-v2"
MAKE_TARGETS = "all"

do_install() {
    install -d ${D}/lib/modules/${KERNEL_VERSION}/kernel/drivers
    install -m 0644 ${B}/easy_csi2_reader.ko -D ${D}/lib/modules/${KERNEL_VERSION}/kernel/drivers/setaku-tof-v2.ko
    install -d ${D}${sysconfdir}/udev/rules.d
    install -m 0644 ${THISDIR}/camera.rules -D ${D}${sysconfdir}/udev/rules.d/camera.rules
    install -d ${D}${sysconfdir}/modprobe.d
    install -m 0644 ${THISDIR}/*.conf -D ${D}${sysconfdir}/modprobe.d/
}

FILES:${PN} += "/lib/modules/${KERNEL_VERSION}/kernel/drivers/setaku-tof-v2.ko \
    ${sysconfdir}/udev/rules.d \
	${sysconfdir}/modprobe.d"