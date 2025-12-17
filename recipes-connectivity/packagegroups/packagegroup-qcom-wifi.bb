SUMMARY = "QCOM WIFI opensource package groups"

LICENSE = "BSD-3-Clause \
           & Qualcomm-Technologies-Inc.-Proprietary"

PACKAGE_ARCH = "${SOC_ARCH}"

inherit packagegroup

PROVIDES = "${PACKAGES}"

PACKAGES = "${PN}"

RDEPENDS:${PN} = " \
    wpa-supplicant \
    linux-firmware-rtl8822 \
"

RDEPENDS:${PN}:append:qcom-custom-bsp = " \
    cld80211-lib \
    wlan-sigma-dut \
"

RDEPENDS:${PN}:append:qcom-base-bsp = " \
    hostapd \
"

RDEPENDS:${PN}:append = "tcpdump rfkill dnsmasq dhcpcd iperf2 iperf3 nftables iputils trace-cmd"


RDEPENDS:${PN}:append:qcom-custom-bsp = "\
	qcom-ath6kl-utils \
	qcom-ftm \
	qcom-wlan-tools \
	qcom-ath11k-fwtest \
	"
