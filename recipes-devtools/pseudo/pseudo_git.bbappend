# Backport pseudo 1.9.8 from poky scarthgap tip (poky is pinned at 5.0.9).
#
# The GitHub Actions runner image update (2026-07-30) broke do_package with:
#   got *at() syscall for unknown directory, fd 4
#   tar: ./usr/bin: Cannot mkdir: Bad address
# pseudo 1.9.0+git in poky 5.0.9 cannot track dirfd-based *at() syscalls
# issued by the updated host tar/glibc. Fixed upstream by pseudo 1.9.3+
# (openat2 support, EFAULT implementation fix). Drop this bbappend once
# the poky submodule is bumped to scarthgap 5.0.16 or later.

# These patches are merged upstream in 1.9.8 and no longer apply.
SRC_URI:remove = "file://0001-configure-Prune-PIE-flags.patch file://glibc238.patch"

SRCREV = "823895ba708c63f6ae4dcbfc266210f26c02c698"
PV = "1.9.8"
