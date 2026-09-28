SUMMARY = "Qualcomm CamX CHI-CDK (kt) built from source"
DESCRIPTION = "CHI-CDK camera stack components (chi override, feature2, nodes, \
sensor modules and tuning binaries) for QCM6490, built from the \
src/vendor/qcom/proprietary/chi-cdk-kt submodule (pf-robotics/chi-cdk-kt) \
instead of the Qualcomm prebuilt tarball.  The PFR ToF sensor module \
(com.qti.sensormodule.pfr_kw33000_cam*.bin) is generated from its XML here."
LICENSE          = "Qualcomm-Technologies-Inc.-Proprietary"
LIC_FILES_CHKSUM = "file://${QCOM_COMMON_LICENSE_DIR}${LICENSE};md5=58d50a3d36f27f1a1e6089308a49b403"

inherit cmake pkgconfig python3native perlnative

# Same runtime dependencies as the prebuilt recipe, plus what the source
# build needs: camx headers/libs (camx-kt, camxlib-kt, camxapi-kt), the camera
# kernel UAPI headers (cameradlkm), protobuf for api/sensor/slots.proto and
# the native perl/python tools used by tools/pfr/autogen-kt.sh.
DEPENDS += "syslog-plumber glib-2.0 property-vault qmi-framework \
            camx-kt camxlib-kt camxapi-kt cameradlkm \
            virtual/libgles2 virtual/egl adrenocl qcom-fastcv-binaries \
            protobuf protobuf-native \
            libxml-simple-perl-native libxml2-native"

# Source tree is the qlipfr submodule src/vendor/qcom/proprietary/chi-cdk-kt.
FILESEXTRAPATHS:prepend := "${TOPDIR}/../src/vendor/qcom/proprietary:"
SRC_URI = "file://chi-cdk-kt/"
S = "${WORKDIR}/chi-cdk-kt"
# The top-level CMakeLists resolves ../chi-cdk-kt relative to itself, so the
# source directory has to keep this name.

COMPATIBLE_MACHINE = "qcm6490"
PACKAGE_ARCH = "${SOC_ARCH}"

TOOLCHAIN = "gcc"

BOARD_PLATFORM = "kodiak"

# Options taken from the Thundersoft/Qualcomm chicdk-kt source recipe
# (env.inc): CMAKE_QLI_NAME enables the meshwarp nodes, BOARD_PLATFORM /
# TARGET_BOARD_PLATFORM select the SoC topology.
EXTRA_OECMAKE += "\
    -DCAMXDEBUG:STRING=True \
    -DPLATFORM:STRING=linux \
    -DCPU:STRING=64 \
    -DCMAKE_CROSSCOMPILING:BOOL=True \
    -DCMAKE_LIBRARY_PATH:PATH=${STAGING_LIBDIR} \
    -DCMAKE_INCLUDE_PATH:PATH=${STAGING_INCDIR} \
    -DKERNEL_INCDIR=${STAGING_INCDIR} \
    -DCMAKE_QLI_NAME:STRING=${TARGET_SYS} \
    -DTARGET_BOARD_PLATFORM:STRING=${BOARD_PLATFORM} \
    -DBOARD_PLATFORM:STRING=sm6490 \
"

# camera kernel UAPI headers installed by cameradlkm
OECMAKE_C_FLAGS:append   = " -I${STAGING_INCDIR}/camera_kt -I${STAGING_INCDIR}/camera"
OECMAKE_CXX_FLAGS:append = " -I${STAGING_INCDIR}/camera_kt -I${STAGING_INCDIR}/camera"

# The XML -> bin converter shipped with the source is a host x86_64 binary
# that only needs libxml2.so.2; make sure it runs before spending time on
# the rest of the build.
do_configure:prepend() {
    # Exit status 100 is "usage" (no arguments); anything else means the
    # binary itself could not start (typically missing libxml2.so.2).
    ${S}/tools/buildbins/linux64/ParameterParser >/dev/null 2>&1 || rc=$?
    if [ "${rc:-0}" != "100" ]; then
        bbfatal "tools/buildbins/linux64/ParameterParser cannot run on this host (exit ${rc:-0}); it is an x86_64 binary that needs libxml2.so.2"
    fi
}

# Generate the sources cmake expects (XSD -> C++, usecase pipelines, logical
# camera / BLM config) and the protobuf for the sensor slot config.
do_autogen() {
    cd ${S}
    bash ${S}/tools/pfr/autogen-kt.sh ${BOARD_PLATFORM}
    install -d ${S}/api/generated/g_slots
    protoc --proto_path=${S}/api/sensor --cpp_out=${S}/api/generated/g_slots ${S}/api/sensor/slots.proto
}
do_autogen[dirs] = "${S}"
do_configure[prefuncs] += "do_autogen"

# Binaries the prebuilt package shipped that have no source in the tree
# (see oem/qcom/prebuilt/README.md in chi-cdk-kt).
do_install:append() {
    install -d ${D}${libdir}/camera
    for f in ${S}/oem/qcom/prebuilt/*.bin; do
        [ -e "$f" ] && install -m 0644 "$f" ${D}${libdir}/camera/
    done
}

FILES:${PN} = "\
    /usr/lib/* \
    /usr/bin/* \
    /usr/lib/rfsa/adsp/* \
    /usr/include/* \
    /lib/firmware/* \
    /system/etc/camera/* "
FILES:${PN}-dev = ""
# Keep the static chi libraries in the main package as the prebuilt did.
FILES:${PN}-staticdev = ""

# The modules are dlopen()ed by camera.qcom by name; keep the unversioned .so
# in the main package and skip the QA checks the prebuilt recipe skipped.
INSANE_SKIP = "1"
INSANE_SKIP:${PN} = "dev-so file-rdeps dev-deps ldflags already-stripped"
