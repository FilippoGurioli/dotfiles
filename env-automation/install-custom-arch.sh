#!/usr/bin/env bash
set -euo pipefail # fail fast strategy

# Checking if the hostname is provided as first parameter
if [ $# -ne 2 ]; then
	echo "Error: provide the host name as first parameter (e.g. desktop/laptop/...) and the root password as second"
	return 1
fi

# Setting an env var to spot if is vm
if grep -qi 'qemu' /sys/class/dmi/id/sys_vendor 2>/dev/null; then
	VM_ENV=1
else
	VM_ENV=0
fi

echo "FIRST BOOT SCRIPT"

echo "Checking connectivity"
if ! ping -c 1 -W 2 8.8.8.8 &> /dev/null; then
	echo "No connection, aborting minimal setup, re-launch this script once there is connectivity"
	return 1
else
	echo "Connected, starting minimal setup"
fi

echo "Updating system clock"
timedatectl set-ntp true

echo "Selecting the fastest 10 mirrors"
sudo reflector --country "Italy,Germany,Switzerland,France" --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

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
sgdisk --zap-all "$SSD_PATH" &>/dev/null
echo "Creating EFI + ROOT partitions"
parted -s "$SSD_PATH" mklabel gpt #GUID Partition Table
parted -s "$SSD_PATH" mkpart EFI fat32 1MiB 513MiB #First partition, name:EFI, type:fat32, from 1MiB to 513 MiB (leaving first MiB blank)
parted -s "$SSD_PATH" set 1 esp on #Setting first partition as EFI System Partition (esp)
parted -s "$SSD_PATH" mkpart ROOT ext4 513MiB 100% #Second partition, name:ROOT, type:ext4, from 513MiB to 100% (end of disk) - the root file system

EFI_PART="${SSD_PATH}1"
ROOT_PART="${SSD_PATH}2"

echo "Formatting partitions"
mkfs.fat -F32 "$EFI_PART" &>/dev/null
mkfs.ext4 -F "$ROOT_PART" &>/dev/null

echo "Mounting EFI + ROOT"
mount "$ROOT_PART" /mnt 2>/dev/null
mkdir /mnt/boot
mount "$EFI_PART" /mnt/boot 2>/dev/null

echo "Installing base functionalities"
pacstrap -K /mnt base linux-zen linux-firmware grub efibootmgr vim

echo "Generating file systems table"
genfstab -U /mnt >> /mnt/etc/fstab

echo "Mounting other disks"
for disk in "${OTHER_DISKS[@]}"; do
	DISK_PATH="/dev/$disk"
	PARTITIONS=$(lsblk -nrpo NAME "$DISK_PATH" | grep -v "$DISK_PATH")
	if [ -z "$PARTITIONS" ]; then
		echo "No partitions on $disk - skipping"
		continue
	fi

	for part in $PARTITIONS; do
		PART_NAME=$(basename "$part")
		MOUNT_DIR="/mnt/$PART_NAME"
		mkdir -p "$MOUNT_DIR"
		mount "$part" "$MOUNT_DIR"
		echo "Mounted $part"
	done
done

echo "Changing root to /mnt"
arch-chroot /mnt

echo "Setting time zone"
ln -sf /usr/share/zoneinfo/Europe/Rome /etc/localtime

echo "Setting localization"
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "en_GB.UTF-8 UTF-8" >> /etc/locale.gen
echo "it_IT.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "LC_ADDRESS=it_IT.UTF-8" >> /etc/locale.conf
echo "LC_IDENTIFICATION=it_IT.UTF-8" >> /etc/locale.conf
echo "LC_MEASUREMENT=it_IT.UTF-8" >> /etc/locale.conf
echo "LC_MONETARY=it_IT.UTF-8" >> /etc/locale.conf
echo "LC_NAME=it_IT.UTF-8" >> /etc/locale.conf
echo "LC_NUMERIC=it_IT.UTF-8" >> /etc/locale.conf
echo "LC_PAPER=it_IT.UTF-8" >> /etc/locale.conf
echo "LC_TELEPHONE=it_IT.UTF-8" >> /etc/locale.conf
echo "LC_TIME=it_IT.UTF-8" >> /etc/locale.conf

NAME="arch-$1"

echo "Setting hostname to $NAME"
echo "$NAME" > /etc/hostname

echo "Setting hosts"
echo "127.0.0.1 localhost" > /etc/hosts
echo "::1 localhost" >> /etc/hosts
echo "127.0.1.1 $NAME.localdomain $NAME" >> /etc/hosts

echo "Setting the root password to $2"
echo "root:$2" | chpasswd

echo "Installing bootloader"
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

echo "MINIMAL INSTALLATION DONE"
echo "Rebooting"
umount -R /mnt
reboot
exit 0
