#!/bin/bash

virsh start arch
vncviewer $(sudo virsh vncdisplay arch)
