#!/bin/bash

sudo virsh start arch
vncviewer $(sudo virsh vncdisplay arch)
