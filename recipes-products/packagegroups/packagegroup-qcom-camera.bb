SUMMARY = "QCOM Camera Package Group"

LICENSE = "BSD-3-Clause-Clear & Qualcomm-Technologies-Inc.-Proprietary"

PACKAGE_ARCH = "${SOC_ARCH}"

inherit packagegroup

PROVIDES = "${PACKAGES}"

PACKAGES = "${PN}"

#qcm6490 is a common SOC_FAMILY name for all Kodiak board
RDEPENDS:${PN}:qcom-custom-bsp:qcm6490 = "setaku-tof-drv-v2"

#qcm6490 is a common SOC_FAMILY name for all Kodiak board
RDEPENDS:${PN}:qcom-base-bsp:qcm6490= "libcamera v4l-utils media-ctl yavta"
