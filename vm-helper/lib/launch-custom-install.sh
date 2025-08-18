#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

"$SCRIPT_DIR/arch-exec.sh" "curl -fsSL https://raw.githubusercontent.com/FilippoGurioli/dotfiles/master/env-automation/install.sh | bash -s -- $1 $2"
