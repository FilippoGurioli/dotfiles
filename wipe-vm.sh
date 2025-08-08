#!/bin/bash

sudo virsh --connect qemu:///system destroy archvm 2>/dev/null
#sudo virsh --connect qemu:///system undefine archvm
#sudo rm /var/lib/libvirt/images/archlinux.qcow2
sudo virsh undefine --remove-all-storage archvm

#sudo qemu-img create -f qcow2 /var/lib/libvirt/images/archlinux.qcow2 20G
sudo virt-install \
#	--connect qemu:///system \
	--name arch
	--ram 2048 \
	--vcpus 4 \
	--disk path=/var/lib/libvirt/images/archlinux.qcow2,format=qcow2,size=20 \
	--cdrom /var/lib/libvirt/isos/archlinux-2025.08.01-x86_64.iso \
	--os-type linux \
	--os-variant archlinux \
#	--network network=default \
#	--graphics vnc \
	--console pty,target_type=serial
