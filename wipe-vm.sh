#!/bin/bash

#sudo virsh --connect qemu:///system destroy arch 2>/dev/null
sudo virsh destroy arch 2>/dev/null
#sudo virsh --connect qemu:///system undefine arch
sudo virsh undefine --remove-all-storage arch
#sudo rm /var/lib/libvirt/images/archlinux.qcow2

#sudo qemu-img create -f qcow2 /var/lib/libvirt/images/archlinux.qcow2 20G
sudo virt-install \
	--name arch \
	--ram 2048 \
	--vcpus 4 \
	--disk path=/var/lib/libvirt/images/archlinux.qcow2,format=qcow2,size=20 \
	--cdrom /var/lib/libvirt/isos/archlinux-2025.08.01-x86_64.iso \
	--os-variant archlinux \
	--console pty,target_type=serial \
	--network network=default \
	--graphics vnc 
	#--connect qemu:///system \

