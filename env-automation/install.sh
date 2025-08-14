#!/usr/bin/env bash
set -euo pipefail # fail fast strategy

BASE_URL="https://raw.githubuserconent.com/FilippoGurioli/dotfiles/master/env-automation/"

curl -fsSL "$BASE_URL/install-custom-arch.sh" -o install-custom-arch.sh
curl -fsSL "$BASE_URL/chroot-commands.sh" -o chroot-commands.sh

./install-custom-arch.sh $@
