SUMMARY = "Prebuilt Chromium browser for Rubik Pi Wayland"
DESCRIPTION = "Installs the Chromium sysroot payload without building Chromium or GN."
HOMEPAGE = "https://www.chromium.org/Home"
LICENSE = "BSD-3-Clause & LGPL-2.0-or-later & LGPL-2.1-or-later"
# The sysroot ZIP does not contain the source tree's license files.
LIC_FILES_CHKSUM = " \
    file://${COMMON_LICENSE_DIR}/BSD-3-Clause;md5=550794465ba0ec5312d6919e203a55f9 \
    file://${COMMON_LICENSE_DIR}/LGPL-2.0-or-later;md5=6d2d9952d88b50a51a5c73dc431d06c7 \
    file://${COMMON_LICENSE_DIR}/LGPL-2.1-or-later;md5=2a4f4fd2128ea2f65047ee63fbca9f68 \
"
PV = "128.0.6613.137"

inherit features_check mime-xdg gtk-icon-cache

REQUIRED_DISTRO_FEATURES = "wayland"
ANY_OF_DISTRO_FEATURES = "opengl vulkan"
COMPATIBLE_HOST = "aarch64.*-linux"
COMPATIBLE_HOST:libc-musl = "null"

# Read the archive directly from the workspace root, outside SRC_URI.
# Override CHROMIUM_PREBUILT_ZIP in local.conf to use another location.
CHROMIUM_PREBUILT_ZIP ?= "${TOPDIR}/../chromium_prebuilt.zip"
SRC_URI = ""
S = "${WORKDIR}/chromium-prebuilt"

do_fetch[noexec] = "1"

python do_unpack() {
    import os
    import zipfile

    archive = d.getVar('CHROMIUM_PREBUILT_ZIP')
    if not os.path.isfile(archive):
        bb.fatal('Chromium prebuilt archive not found: %s' % archive)
    with zipfile.ZipFile(archive) as payload:
        payload.extractall(d.getVar('S'))
}
# Remove old payload files before extracting a replacement archive.
do_unpack[cleandirs] = "${S}"
# Keep task signatures sensitive to archive contents even without SRC_URI.
do_unpack[file-checksums] += "${CHROMIUM_PREBUILT_ZIP}:True"

# Populate shlibs metadata for automatic ELF runtime dependency resolution.
# These are library recipes only; no Chromium/GN build dependency is needed.
DEPENDS += " \
    alsa-lib at-spi2-core dbus expat flac glib-2.0 gtk+3 jpeg \
    libcxx libdrm libxkbcommon libxslt nspr nss wayland \
    virtual/egl virtual/libgles2 \
"
# Match the original wrapper and non-ELF runtime requirements.
RDEPENDS:${PN} += "bash gtk+3 upower"
RCONFLICTS:${PN} = "chromium-ozone-wayland chromium-x11"

do_configure[noexec] = "1"
do_compile[noexec] = "1"

do_install() {
    test -s ${S}/usr/lib/chromium/chromium-bin || bbfatal "Missing prebuilt chromium-bin"
    test -s ${S}/usr/lib/chromium/chromium-wrapper || bbfatal "Missing prebuilt chromium-wrapper"

    install -d ${D}${libdir}/chromium ${D}${bindir} ${D}${datadir}
    cp -R --no-preserve=ownership ${S}/usr/lib/chromium/. ${D}${libdir}/chromium/
    cp -R --no-preserve=ownership ${S}/usr/share/. ${D}${datadir}/

    # ZIP extraction must not determine executable or sandbox permissions.
    chmod 0755 ${D}${libdir}/chromium/chromium-bin \
        ${D}${libdir}/chromium/chromium-wrapper \
        ${D}${libdir}/chromium/chrome_crashpad_handler
    chmod 4755 ${D}${libdir}/chromium/chrome-sandbox
    ln -s ${libdir}/chromium/chromium-wrapper ${D}${bindir}/chromium

    # sysroots-components omits applications and /usr/bin. The supplied
    # wrapper already includes --use-gl=egl and --ozone-platform=wayland.
    install -d ${D}${datadir}/applications
    cat > ${D}${datadir}/applications/chromium.desktop << 'EOF'
[Desktop Entry]
Type=Application
Name=Chromium Browser
Exec=chromium %U
Terminal=false
Icon=chromium
Categories=Network;WebBrowser;
MimeType=text/html;x-scheme-handler/http;x-scheme-handler/https;
EOF
}

FILES:${PN} = " \
    ${bindir}/chromium \
    ${libdir}/chromium \
    ${datadir}/applications/chromium.desktop \
    ${datadir}/icons/hicolor/*x*/apps/chromium.png \
"

# Keep bundled ANGLE/SwiftShader libraries private to this browser.
PRIVATE_LIBS = "libEGL.so libGLESv2.so libvulkan.so.1 libvk_swiftshader.so"
INHIBIT_PACKAGE_STRIP = "1"
INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
INSANE_SKIP:${PN} += "already-stripped"
