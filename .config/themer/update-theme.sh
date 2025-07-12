#!/bin/bash

sassc ~/.config/themer/wofi.scss   ~/.config/wofi/style.css
sassc ~/.config/themer/waybar.scss ~/.config/waybar/style.css

~/.config/themer/libs/parse-scss-vars.sh ~/.config/themer/my-theme.scss
source ~/.config/themer/libs/autogen/my-theme.sh

~/.config/themer/libs/expand-env-vars.sh ~/.config/themer/kitty.conf ~/.config/kitty/kitty.conf
~/.config/themer/libs/expand-env-vars.sh ~/.config/themer/waybar.json ~/.config/waybar/config
