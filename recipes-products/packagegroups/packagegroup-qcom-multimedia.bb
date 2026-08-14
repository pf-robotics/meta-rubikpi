SUMMARY = "Qualcomm multimedia packagegroups"
DESCRIPTION = "Package groups to bring in packages required to enable multimedia support"

LICENSE = "BSD-3-Clause-Clear"

PACKAGE_ARCH = "${TUNE_PKGARCH}"

inherit packagegroup

PROVIDES = "${PACKAGES}"

PACKAGES = "${PN}"

RDEPENDS:${PN} = "\
    gstreamer1.0 \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-rtsp-server \
    packagegroup-qcom-camera \
    packagegroup-qcom-display \
    packagegroup-qcom-audio \
    "

RDEPENDS:${PN}:append:qcom-custom-distro = "\
    packagegroup-qcom-graphics \
    packagegroup-qcom-iot-base-utils \
    packagegroup-qcom-video \
    "

