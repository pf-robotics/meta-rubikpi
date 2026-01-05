#!/bin/sh

ACTION="$1"
DEVICE="$2"

MOUNT_DIR="/var/opt/pfr/external"
BOARD_DIR="/dev/$DEVICE"

echo "ACTION: $ACTION"

case "$ACTION" in
	add)

		mkdir -p "$MOUNT_DIR" 
		echo " MOUNT_DIR: $MOUNT_DIR"
		echo " BOARD_DIR= $BOARD_DIR"
		mount -t auto "$BOARD_DIR" "$MOUNT_DIR"
		;;
	remove)
		echo " BOARD_DIR: $BOARD_DIR"
		umount "$MOUNT_DIR"
		;;
esac
