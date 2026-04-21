#!/bin/sh
# PFR Full-Disk Encryption unlock hook.
#
# Called from ostree-initrd init.sh before the otaroot mount.
# Looks for a LUKS2 header on /dev/disk/by-partlabel/system; if present,
# tries to unlock it to /dev/mapper/otaroot. Key sources in priority:
#   1. PFR_FDE_KEY_FD  file descriptor passed from QTEE helper  (Phase 2)
#   2. /run/pfr-fde/master.key  in-memory tmpfs key file         (Phase 2)
#   3. Passphrase prompt on /dev/console                        (Phase 1)
#
# If no LUKS header is found, exits 0 so the boot proceeds unchanged
# (backward compatibility with un-encrypted rollout).

set -u

log() { echo "pfr-luks-unlock: $*" >&2; }

SYSTEM_DEV="/dev/disk/by-partlabel/system"
MAPPER_NAME="otaroot"

# Backward-compat bailout: if no system partition label yet, skip silently.
if [ ! -e "${SYSTEM_DEV}" ]; then
    log "no ${SYSTEM_DEV}; skipping (unexpected, but letting boot continue)"
    exit 0
fi

if ! cryptsetup isLuks "${SYSTEM_DEV}" 2>/dev/null; then
    log "no LUKS header on ${SYSTEM_DEV}; skipping (unencrypted rollout)"
    exit 0
fi

# Already open from a prior invocation?
if [ -e "/dev/mapper/${MAPPER_NAME}" ]; then
    log "${MAPPER_NAME} already open"
    exit 0
fi

try_keyfile() {
    kf="$1"
    [ -r "${kf}" ] || return 1
    log "trying key from ${kf}"
    cryptsetup open --type luks2 --key-file "${kf}" \
        "${SYSTEM_DEV}" "${MAPPER_NAME}"
}

try_passphrase() {
    log "LUKS passphrase required for ${SYSTEM_DEV}"
    # Prompt on the console so operators can unlock during recovery.
    cryptsetup open --type luks2 "${SYSTEM_DEV}" "${MAPPER_NAME}" \
        </dev/console >/dev/console 2>&1
}

# Phase 2 (QTEE) integration point: a helper service would populate
# /run/pfr-fde/master.key on a tmpfs before this script runs.
if try_keyfile /run/pfr-fde/master.key; then
    log "unlocked via tmpfs key"
    shred -u /run/pfr-fde/master.key 2>/dev/null || rm -f /run/pfr-fde/master.key
    exit 0
fi

# Phase 1 fallback: passphrase.
if try_passphrase; then
    log "unlocked via passphrase"
    exit 0
fi

log "FAILED to unlock ${SYSTEM_DEV}"
exit 1
