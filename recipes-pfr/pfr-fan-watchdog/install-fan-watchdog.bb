SUMMARY = "Install the fan watchdog service and scripts"
DESCRIPTION = "This recipe installs the fan watchdog service and scripts to monitor and control the FAN 12v."
LICENSE = "CLOSED"

SRC_URI += "\
    file://fan-watchdog.service \
"

FILES:${PN} += "\
    ${bindir}/fan-watchdog.py \
    /etc/systemd/system/fan-watchdog.service \
    /etc/systemd/system/multi-user.target.wants/fan-watchdog.service \
"

# do not cache, run every time to ensure the latest image is copied
do_install[nostamp] = "1"
do_install() {
    # Install the scripts
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/*.py ${D}${bindir}/

    # Install the systemd service
    install -d ${D}/etc/systemd/system/
    install -m 0644 ${WORKDIR}/fan-watchdog.service ${D}/etc/systemd/system/

    # Enable the service
    install -d ${D}/etc/systemd/system/multi-user.target.wants
    ln -sf /etc/systemd/system/fan-watchdog.service ${D}/etc/systemd/system/multi-user.target.wants/fan-watchdog.service
}