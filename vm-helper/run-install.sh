#!/bin/bash

STATUS= #libvirt-status

if [ STATUS -e 0 ]; then
	sudo systemctl enable --now libvirtd
fi

./lib/wipe-vm.sh && ./lib/build-vm.sh && ./lib/launch-custom-install.sh $1 $2
