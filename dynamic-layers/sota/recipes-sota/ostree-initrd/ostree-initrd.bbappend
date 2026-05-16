FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " file://pfr-luks-unlock.sh"

do_install:append:qcom() {
    install -Dm 0755 ${WORKDIR}/pfr-luks-unlock.sh ${D}/usr/lib/ostree-initrd/pfr-luks-unlock.sh

    # Insert the LUKS unlock hook before the first (top-level, column 0)
    # occurrence of the otaroot mount. init.sh has a second mount call
    # inside an || { } retry block indented with spaces, so anchor with ^.
    sed -i '/^mount "$ostree_sysroot" \/sysroot/i /usr/lib/ostree-initrd/pfr-luks-unlock.sh || bail_out "LUKS unlock failed"' ${D}/init

    # Enable inlinecrypt on the otaroot mount. Must run AFTER the insert
    # above since this rewrites the same line pattern.
    sed -i 's|mount "$ostree_sysroot" /sysroot|mount -o inlinecrypt "$ostree_sysroot" /sysroot|g' ${D}/init
}

FILES:${PN} += " /usr/lib/ostree-initrd/pfr-luks-unlock.sh "
