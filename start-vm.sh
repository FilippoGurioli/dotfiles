#!/bin/bash

sudo virsh start archvm
vncviewer $(sudo virsh --connect qemu:///system vncdisplay archvm)
