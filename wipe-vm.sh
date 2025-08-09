#!/bin/bash

sudo virsh destroy arch 2>/dev/null
sudo virsh undefine --remove-all-storage arch
sudo virsh net-destroy default
sudo virsh net-undefine default
