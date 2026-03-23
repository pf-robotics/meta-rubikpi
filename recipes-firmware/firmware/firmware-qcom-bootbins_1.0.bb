DESCRIPTION = "Recipe to install NHLOS images in DEPLOY_DIR"
LICENSE          = "Qualcomm-Technologies-Inc.-Proprietary"
LIC_FILES_CHKSUM = "file://${QCOM_COMMON_LICENSE_DIR}/${LICENSE};md5=58d50a3d36f27f1a1e6089308a49b403"

COMPATIBLE_MACHINE = "qcm6490|qcs9100|qcs8300|qcs615"

PROVIDES += "virtual/bootbins"

SRC_URI = "file://${FWZIP_PATH}/${BOOTBINARIES}.zip"

include firmware-common.inc

MATCHED_MACHINE = "${@get_matching_machine(d)}"
include firmware-${MATCHED_MACHINE}.inc

BOOTBINARIES:qcm6490 = "QCM6490_bootbinaries"
BOOTBINARIES:qcs9100 = "QCS9100_bootbinaries"
BOOTBINARIES:qcs8300 = "QCS8300_bootbinaries"
BOOTBINARIES:qcs615  = "QCS615_bootbinaries"

do_configure[noexec] = "1"
do_compile[noexec] = "1"

python do_install() {

    workdir = d.getVar('WORKDIR')
    fw_folder = d.getVar("BOOTBINARIES")
    
    import shutil
    shutil.copytree(f'{workdir}/{fw_folder}', d.getVar('D'), dirs_exist_ok=True)

    # Remove partition xmls.
    for item in os.listdir(d.getVar('D')):
        name, ext = os.path.splitext(item)
        if name.startswith('partition') and ext == '.xml':
            os.remove(os.path.join(d.getVar('D'), item))
        if name.startswith('contents') and ext == '.xml':
            os.remove(os.path.join(d.getVar('D'), item))

}

inherit deploy

do_deploy() {
    find "${D}" -maxdepth 1 -name '*.bin' -exec install -m 0644 {} ${DEPLOYDIR} \;
    find "${D}" -maxdepth 1 -name '*.elf' -exec install -m 0644 {} ${DEPLOYDIR} \;
    find "${D}" -maxdepth 1 -name '*.fv' -exec install -m 0644 {} ${DEPLOYDIR} \;
    find "${D}" -maxdepth 1 -name '*.mbn' -exec install -m 0644 {} ${DEPLOYDIR} \;
    find "${D}" -maxdepth 1 -name '*.melf' -exec install -m 0644 {} ${DEPLOYDIR} \;
    # Copy sail_nor files to deploydir
    for f in $(find "${D}/sail_nor" -type f -printf '%P ') ; do
        install -d ${DEPLOYDIR}/sail_nor
        install -m 0644 ${D}/sail_nor/$f ${DEPLOYDIR}/sail_nor/$f
    done
}
addtask deploy before do_build after do_install

PACKAGE_ARCH = "${SOC_ARCH}"

PACKAGES += "${PN}-copyright"

FILES:${PN} += "/*.elf /*.mbn /*.bin /*.fv */.melf /sail_nor/* /*.img"
FILES:${PN}-copyright += "/Qualcomm-Technologies-Inc.-Proprietary"

INSANE_SKIP:${PN} = "arch"
