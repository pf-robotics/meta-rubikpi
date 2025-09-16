SUMMARY = "rubikpi config"
DESCRIPTION = "rubik PI Device Configuration Tool"
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""

SRCPROJECT = "git://github.com/pf-robotics/tools.git;protocol=ssh"
SRCBRANCH  = "pfr-main-2025-09-16-0"
SRCREV = "f22d846e7204c88406c2c0d44ea5b4cdcbf3803b"

SRC_URI =  "${SRCPROJECT};branch=${SRCBRANCH}"

S = "${WORKDIR}/git"

do_install() {
	install -d ${D}${bindir}

	install -m 0755 ${S}/rubikpi_config ${D}${bindir}/
}
