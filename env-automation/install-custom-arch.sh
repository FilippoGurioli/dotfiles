#!/usr/bin/env bash
set -euo pipefail # fail fast strategy

# Setting an env var to spot if is vm
if grep -qEi 'QEMU' /sys/class/dmi/id/sys_vendor 2>/dev/null; then
	VM_ENV=1
else
	VM_ENV=0
fi

echo "FIRST BOOT SCRIPT"

echo "Checking connectivity"
if ! ping -c 1 -W 2 8.8.8.8 &> /dev/null; then
	echo "No connection aborting minimal setup, re-launch this script once there is connectivity"
	return 1
else
	echo "Connected, starting minimal setup"
fi

echo "Updating system clock"
timedatectl set-ntp true

echo "Selecting the fastest 10 mirrors"
reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist

echo "Partitioning the disk"
if [ $VM_ENV ]; then
	SSD_DISK=$(lsblk -d -o NAME,TYPE | awk '$2=="disk" {print $1; exit}')
else
	SSD_DISK=$(lsblk -d -o NAME,ROTA,TYPE | awk '$3=="disk" && $2==0 {print $1; exit}')
fi
SSD_PATH="/dev/$SSD_DISK"

if [ -z "$SSD_DISK" ]; then
	echo "No SSD detected. Aborting."
	exit 1
fi

OTHER_DISKS=($(lsblk -d -o NAME,ROTA | awk -v ssd="$SSD_DISK" '$1!=ssd && $1!="NAME" {print $1}'))

echo "SSD: $SSD_PATH"
echo "OTHERS: $OTHER_DISKS"

echo "Wiping the existing partitions in $SSD_PATH"
sgdisk --zap-all "$SSD_PATH" 2>/dev/null
