SUMMARY = "Qualcomm multimedia packagegroups"
DESCRIPTION = "Package groups to bring in packages required to enable multimedia support"

LICENSE = "BSD-3-Clause-Clear"

PACKAGE_ARCH = "${TUNE_PKGARCH}"

inherit packagegroup

PROVIDES = "${PACKAGES}"

PACKAGES = "${PN}"

RDEPENDS:${PN} = "\
    tensorflow-lite \
    ${@bb.utils.contains('DISTRO_FEATURES', 'virtualization', 'packagegroup-qcom-containers', '', d)} \
    ${@bb.utils.contains('DISTRO_FEATURES', 'virtualization', 'packagegroup-qcom-k8s', '', d)} \
    packagegroup-qcom-opencv \
    packagegroup-qcom-camera \
    packagegroup-qcom-display \
    packagegroup-qcom-audio \
    "

RDEPENDS:${PN}:append:qcom-custom-distro = "\
    packagegroup-qcom-fastcv \
    packagegroup-qcom-graphics \
    packagegroup-qcom-iot-base-utils \
    packagegroup-qcom-video \
    "

