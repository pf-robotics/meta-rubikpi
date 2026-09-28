DESCRIPTION = "tof_ctrl: user-space tool for /dev/tof<slot>_ctrl of the Setaku ToF driver"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/${LICENSE};md5=801f80980d171dd6425610833a22dbe6"

# Same local source tree as setaku-tof-drv (kernel module); only tools/ and
# the uapi header are used here.
LOCAL_DRV_SRC = "${TOPDIR}/../src/tof_cam_drv"
S = "${WORKDIR}/tof_cam_drv"

# do not cache
do_unpack[nostamp] = "1"
do_unpack[cleandirs] = "${S}"
do_unpack() {
    install -d ${S}
    cp -aL ${LOCAL_DRV_SRC}/. ${S}/
}

do_configure[noexec] = "1"

do_compile() {
    oe_runmake -C ${S}/tools CC="${CC}" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${S}/tools/tof_ctrl ${D}${bindir}/tof_ctrl
    install -d ${D}${includedir}
    install -m 0644 ${S}/tof_cam_uapi.h ${D}${includedir}/tof_cam_uapi.h
}

RDEPENDS:${PN} += "setaku-tof-drv"
