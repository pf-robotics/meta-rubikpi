# Create /var/spool/mail directory at run-time to skip warnings
# that are reported at build time while using OSTree for SOTA updates.

FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI:append:qcom = " file://shadow.conf "

do_install:append:qcom(){
    if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
        install -d ${D}/etc/tmpfiles.d
        install -m 0644 ${WORKDIR}/shadow.conf ${D}/etc/tmpfiles.d/shadow.conf
        rm -rf ${D}${localstatedir}
    fi
}

pkg_postinst_ontarget:${PN}() {
if [ -n "$D" ]; then
    exit 1
fi
chage -I -1 -m 0 -M 99999 -E -1 root
}
