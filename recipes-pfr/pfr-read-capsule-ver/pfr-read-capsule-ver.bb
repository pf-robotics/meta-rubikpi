SUMMARY = "Read last capsule update attempt and SYSFW_VERSION data"
DESCRIPTION = "Read last capsule update attempt and SYSFW_VERSION data from the system and print it to stdout. Also, write the data to /tmp/last_capsule_status.json for consumption by other scripts"
LICENSE = "CLOSED"

SRC_URI += "\
    file://read_capsule_ver.py \
    file://read_capsule_ver.service \
"

FILES:${PN} += "\
    ${bindir}/read_capsule_ver.py \
    /etc/systemd/system/read_capsule_ver.service \
    /etc/systemd/system/multi-user.target.wants/read_capsule_ver.service \
"

# do not cache, run every time to ensure the latest image is copied
do_install[nostamp] = "1"
do_install() {
    # Install the scripts
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/read_capsule_ver.py ${D}${bindir}/read_capsule_ver.py

    # Install the systemd service
    install -d ${D}/etc/systemd/system/
    install -m 0644 ${WORKDIR}/read_capsule_ver.service ${D}/etc/systemd/system/

    # Enable the service
    install -d ${D}/etc/systemd/system/multi-user.target.wants
    ln -sf /etc/systemd/system/read_capsule_ver.service ${D}/etc/systemd/system/multi-user.target.wants/read_capsule_ver.service
}
