SUMMARY = "PFR camera configuration files"
DESCRIPTION = "Installs camxoverridesettings.txt to /var/lib/camera/ via tmpfiles.d"
LICENSE = "CLOSED"

SRC_URI = "file://camxoverridesettings.txt"

S = "${WORKDIR}"

inherit allarch

do_install() {
    # Install the file to the read-only rootfs as the source template.
    install -d ${D}${datadir}/camera
    install -m 0644 ${WORKDIR}/camxoverridesettings.txt ${D}${datadir}/camera/

    # Install tmpfiles.d rule to create /var/lib/camera/ and copy the file
    # on first boot (C = copy only if destination does not yet exist).
    install -d ${D}${libdir}/tmpfiles.d
    cat > ${D}${libdir}/tmpfiles.d/pfr-camera-config.conf << 'EOF'
d /var/cache/camera 0755 root root -
C /var/cache/camera/camxoverridesettings.txt - - - - /usr/share/camera/camxoverridesettings.txt
EOF
}

FILES:${PN} = "\
    ${datadir}/camera/camxoverridesettings.txt \
    ${libdir}/tmpfiles.d/pfr-camera-config.conf \
"
