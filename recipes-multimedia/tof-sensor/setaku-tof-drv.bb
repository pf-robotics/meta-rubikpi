inherit module

DESCRIPTION = "Setaku ToF Sensor Driver"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/${LICENSE};md5=801f80980d171dd6425610833a22dbe6"

LOCAL_DRV_SRC = "${TOPDIR}/../src/tof_cam_drv"
S = "${WORKDIR}/tof_cam_drv"

do_unpack[nostamp] = "1" # do not cache
do_unpack[cleandirs] = "${S}"
do_unpack() {
    install -d ${S}
    cp -aL ${LOCAL_DRV_SRC}/. ${S}/
}

EXTRA_OEMAKE += "CAMERA_KERNEL_ROOT='${TOPDIR}/../src/camera-kernel'"

RPROVIDES:${PN} += "kernel-module-setaku-tof"
MAKE_TARGETS = "all"
MODULES_INSTALL_TARGET = "install"