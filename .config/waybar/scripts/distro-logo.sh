#!/bin/bash

# Get distro ID from /etc/os-release
distro=$(grep '^ID=' /etc/os-release | cut -d= -f2 |  tr '[:upper:]' '[:lower:]' | tr -d '"')

# Define folder where logos are stored
logo_dir="$HOME/.config/waybar/distro-logos"

# Default to generic logo if distro logo not found
logo_file="$logo_dir/$distro.png"
if [[ ! -f "$logo_file" ]]; then
    logo_file="$logo_dir/linux.png"
fi

echo $logo_file