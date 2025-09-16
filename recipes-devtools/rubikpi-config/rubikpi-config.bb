SUMMARY = "rubikpi config"
DESCRIPTION = "rubik PI Device Configuration Tool"
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""

SRC_URI = "git://git@github.com/pf-robotics/rubikpi-ai-tools.git;protocol=ssh;branch=pfr-main-2025-09-16-0"
SRCREV = "f22d846e7204c88406c2c0d44ea5b4cdcbf3803b"

S = "${WORKDIR}/git"

RDEPENDS:${PN} += "glibc (>= 2.39)"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${S}/rubikpi_config ${D}${bindir}/
}
