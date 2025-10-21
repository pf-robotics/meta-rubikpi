SUMMARY = "Dracut compatibility package for Plymouth"
DESCRIPTION = "This is a minimal dracut compatibility package to satisfy Plymouth dependencies"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

ALLOW_EMPTY:${PN} = "1"
ALLOW_EMPTY:${PN}-dev = "1"

# This is a dummy package that doesn't actually provide anything
# It just exists to satisfy Plymouth's dependency on dracut
RPROVIDES:${PN} = "dracut"

PACKAGES = "${PN} ${PN}-dev"
