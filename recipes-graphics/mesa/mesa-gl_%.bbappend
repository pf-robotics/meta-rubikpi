do_install:append:qcom-custom-bsp() {
    rm -rf ${D}${includedir}/KHR/*
}

# Enable the Mesa Freedreno gallium driver on Qualcomm machines.
# The meta-qcom layer enables this via mesa_%.bbappend, but that appends only
# to the mesa recipe. For qcom-custom-bsp the selected virtual/mesa provider
# is mesa-gl, so we need the same PACKAGECONFIG append here to produce
# msm_dri.so and let Chromium/libgbm allocate dmabuf-backed buffers on Adreno.
PACKAGECONFIG_FREEDRENO = "\
    freedreno \
"

# Enabling freedreno pulls in the kmsro gallium target, which in turn requires
# dri3 whenever the build also has X11 enabled (as is the case for mesa-gl on
# qcom-custom-bsp). Add dri3 conditionally so meson configure does not fail with
# "kmsro requires dri3 for X11 support".
PACKAGECONFIG_FREEDRENO += "${@bb.utils.contains('DISTRO_FEATURES', 'x11', ' dri3', '', d)}"

PACKAGECONFIG:append:qcom = " ${PACKAGECONFIG_FREEDRENO}"
