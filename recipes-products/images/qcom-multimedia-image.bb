require qcom-console-image.bb
inherit populate_sdk_qt5

SUMMARY = "Basic Wayland image with Weston"

LICENSE = "BSD-3-Clause-Clear"

# let's make sure we have a good image.
REQUIRED_DISTRO_FEATURES += "wayland"

CORE_IMAGE_BASE_INSTALL += " \
    packagegroup-qcom-multimedia \
    packagegroup-rubikpi \
    rubikpi-bt-staticdev \
    rwreservepartition \
    ax88179bprogrammer \
    packagegroup-qt5-toolchain-target \
    rubikpi-config \
    packagegroup-qcom-test-pkgs \
    first-login \
    usb-scripts-automount \
    rubikpi3-thermal \
    pfr-ansible-bootstrap \
"

IMAGE_INSTALL:append = " \
    hostapd \
    i2c-tools \
    minicom \
    make cmake \
    iperf3 iperf2 \
    tcpdump lmbench wget lighttpd \
    adduser iproute2 python3-pip sudo \
    rwreservepartition \
    ax88179bprogrammer \
    libcec \
    cec-client \
    python3-pyqt5 python3-pytest-qt \
    iotop lsof \
    var-rubikpi-config-mount \
    wiringrp wiringrp-python wiringrp-gpio \
    glibc-utils \
    fontconfig \
    ttf-vlgothic \
    glibc-gconv-euc-jp \
    glibc-gconv-sjis \
    locale-base-ja-jp \
    chromium-ozone-wayland \
"

EXTRA_USERS_PARAMS = "\
    usermod -s /bin/bash root; \
    usermod -p '\$6\$FIumPDif04\$xNtcC1aRH.k0FnCrzUH807bD6uND43RMUWPzIDnXgp0JDrC86mCVFfp1o7jH/6qCRXGPpStTcZUo4zkJkcSE31' root; \
    "

EXTRA_IMAGE_FEATURES += "tools-sdk"

# This image is sufficiently large, need to be careful that it fits in the partition.
# Nullify the overhead factor added in minimal image and explicitly add just 1GB.
IMAGE_OVERHEAD_FACTOR = "1.5"
IMAGE_ROOTFS_EXTRA_SPACE = "1048576"

EXTRA_IMAGE_FEATURES:append = " tools-testapps ptest-pkgs"

do_deploy_fixup:append() {
    # copy splash.img
    if [ -f ${DEPLOY_DIR_IMAGE}/splash.img ]; then
        install -m 0644 ${DEPLOY_DIR_IMAGE}/splash.img splash.img
    fi

    # copy rubikpi_dtso.img
    if [ -f ${DEPLOY_DIR_IMAGE}/rubikpi_config.img ]; then
        install -m 0644 ${DEPLOY_DIR_IMAGE}/rubikpi_config.img rubikpi_config.img
    fi

    # copy devcfg_full.img
    if [ -f ${DEPLOY_DIR_IMAGE}/devcfg_full.img ]; then
        install -m 0644 ${DEPLOY_DIR_IMAGE}/devcfg_full.img devcfg_full.img
    fi

    # copy rubikpi_dtso.img
    if [ -f ${DEPLOY_DIR_IMAGE}/rubikpi_dtso.img ]; then
        install -m 0644 ${DEPLOY_DIR_IMAGE}/rubikpi_dtso.img rubikpi_dtso.img
    fi

    # copy RubikPi3_CDT.bin
    if [ -f ${DEPLOY_DIR_IMAGE}/RubikPi3_CDT.bin ]; then
        install -m 0644 ${DEPLOY_DIR_IMAGE}/RubikPi3_CDT.bin RubikPi3_CDT.bin
    fi

    # copy usb_fw.img
    if [ -f ${DEPLOY_DIR_IMAGE}/usb_fw.img ]; then
        install -m 0644 ${DEPLOY_DIR_IMAGE}/usb_fw.img usb_fw.img
    fi

    # copy initramfs-ostree-image-qcm6490-idp.cpio.gz
    if [ -f ${DEPLOY_DIR_IMAGE}/initramfs-ostree-image-qcm6490-idp.cpio.gz ]; then
        install -m 0644 ${DEPLOY_DIR_IMAGE}/initramfs-ostree-image-qcm6490-idp.cpio.gz initramfs-ostree-image-qcm6490-idp.cpio.gz
    fi
    # copy ukify
    # if [ -f ${DEPLOY_DIR_IMAGE}/initramfs-ostree-image-qcm6490-idp.cpio.gz ]; then
    #     install -m 0644 ${DEPLOY_DIR_IMAGE}/initramfs-ostree-image-qcm6490-idp.cpio.gz initramfs-ostree-image-qcm6490-idp.cpio.gz
    # fi
    # copy linuxaa64.efi.stub
    if [ -f ${DEPLOY_DIR_IMAGE}/linuxaa64.efi.stub ]; then
        install -m 0644 ${DEPLOY_DIR_IMAGE}/linuxaa64.efi.stub linuxaa64.efi.stub
    fi
}
