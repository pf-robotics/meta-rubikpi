DESCRIPTION = "DTB Partition Image to boot Qualcomm boards"
LICENSE = "BSD-3-Clause-Clear"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/BSD-3-Clause-Clear;md5=7a434440b651f4a472ca93716d01033a"

COMPATIBLE_HOST = '(x86_64.*|arm.*|aarch64.*)-(linux.*)'

PACKAGE_INSTALL = " \
    linux-qcom-mergedtb-combined \
"

KERNELDEPMODDEPEND = ""
KERNEL_DEPLOY_DEPEND = ""

inherit image

IMAGE_FSTYPES = "vfat"
IMAGE_FSTYPES_DEBUGFS = ""

# UFS requires logical sector size >= 4096; force 4096-byte sectors so UEFI
# can read the FAT filesystem from the dtb_a partition.
EXTRA_IMAGECMD:vfat = "-S 4096"

ROOTFS_SIZE = "65536"

LINGUAS_INSTALL = ""
