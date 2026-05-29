# Seed initial persistent /root content into the OTA sysroot.
# In OSTree layouts used by meta-updater, /root is a symlink to /var/roothome,
# which is treated as persistent (not part of the OSTree commit).

IMAGE_CMD:ota:append() {
    cp -a ${IMAGE_ROOTFS}/root ${OTA_SYSROOT}/ostree/deploy/${OSTREE_OSNAME}/var/roothome
    chmod 700 ${OTA_SYSROOT}/ostree/deploy/${OSTREE_OSNAME}/var/roothome
}
