# Plymouth configuration for RubikPi

# Enable Plymouth service
SYSTEMD_AUTO_ENABLE:${PN} = "enable"

# Ensure Plymouth is enabled at boot
do_install:append() {
    # Enable Plymouth in systemd configuration
    if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
        install -d ${D}${sysconfdir}/systemd/system/sysinit.target.wants/
        ln -sf ${systemd_system_unitdir}/plymouth-start.service \
               ${D}${sysconfdir}/systemd/system/sysinit.target.wants/plymouth-start.service
    fi

    # Add custom theme if needed
    # install -d ${D}${datadir}/plymouth/themes/rubikpi
    # install -m 0644 ${WORKDIR}/rubikpi.png ${D}${datadir}/plymouth/themes/rubikpi/
    # install -m 0644 ${WORKDIR}/rubikpi.plymouth ${D}${datadir}/plymouth/themes/rubikpi/
}

# Add custom configuration files
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://plymouthd.conf"

do_install:append() {
    install -d ${D}${sysconfdir}/plymouth
    install -m 0644 ${WORKDIR}/plymouthd.conf ${D}${sysconfdir}/plymouth/plymouthd.conf
}
