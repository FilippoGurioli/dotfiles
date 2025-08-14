#!/bin/bash

IP=$(virsh domifaddr arch | awk '/ipv4/ {print $4; exit}' | cut -d/ -f1 || true)

ssh user@$IP 'curl -fsSL "https://raw.githubusercontent.com/FilippoGurioli/dotfiles/master/env-automation/install.sh" | bash -s -- $1 $2'