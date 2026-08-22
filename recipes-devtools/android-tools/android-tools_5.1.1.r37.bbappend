FILESEXTRAPATHS:prepend := "${THISDIR}/android-tools:"

# adbd (AOSP 5.1.1) reads the authorized public keys from /adb_keys and
# /data/misc/adb/adb_keys only, and neither path is configurable. Both live
# directly under /, which belongs to the OSTree deployment and is immutable at
# runtime, so the entry has to be part of the image.
#
# Ship /adb_keys as a symlink into /etc instead of a regular file: OSTree merges
# /etc across deployments, so the key list survives an OTA and can be managed at
# runtime, while / itself stays owned by the commit. The key file is not shipped
# here; adbd rejects every client until one is provisioned, which is the
# intended default.
do_install:append() {
    if echo ${TOOLS} | grep -q "adbd" ; then
        install -d ${D}${sysconfdir}/adb
        ln -sf ${sysconfdir}/adb/adb_keys ${D}/adb_keys
    fi
}

FILES:${PN}-adbd += "/adb_keys ${sysconfdir}/adb"
