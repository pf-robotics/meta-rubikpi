# Plymouth configuration for RubikPi

# Enable Plymouth service
SYSTEMD_AUTO_ENABLE:${PN} = "enable"

# Remove dracut dependency (which is not available in our layers)
RDEPENDS:${PN}:remove = "dracut"

# Ensure Plymouth is enabled at boot
python __anonymous() {
    # Fix for ERROR: Nothing RPROVIDES 'dracut'
    rdepends = d.getVar('RDEPENDS:' + d.getVar('PN'))
    if rdepends and 'dracut' in rdepends.split():
        new_rdepends = ' '.join([r for r in rdepends.split() if r != 'dracut'])
        d.setVar('RDEPENDS:' + d.getVar('PN'), new_rdepends)
}

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

# Explicitly remove dracut dependency
RDEPENDS:${PN}:remove = "dracut"

# Explicitly specify dependencies
DEPENDS = "libpng libdrm"
RDEPENDS:${PN} = "libpng libdrm"

do_install:append() {
    install -d ${D}${sysconfdir}/plymouth
    install -m 0644 ${WORKDIR}/plymouthd.conf ${D}${sysconfdir}/plymouth/plymouthd.conf
}
