#!/bin/bash

sudo virt-install \
	--name arch \
	--ram 2048 \
	--vcpus 4 \
	--disk path=/var/lib/libvirt/images/archlinux.qcow2,format=qcow2,size=20 \
	--cdrom /var/lib/libvirt/isos/archlinux-2025.08.01-x86_64.iso \
	--os-variant archlinux \
	--network network=default \
	--graphics vnc 
