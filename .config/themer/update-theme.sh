#!/bin/bash

sassc ~/.config/themer/wofi.scss   ~/.config/wofi/style.css
sassc ~/.config/themer/waybar.scss ~/.config/waybar/style.css

~/.config/themer/parse-scss-vars.sh ~/.config/themer/my-theme.scss ~/.config/themer/my-theme.sh
source ~/.config/themer/my-theme.sh

~/.config/themer/expand-env-vars.sh ~/.config/themer/kitty.conf.template ~/.config/kitty/kitty.conf
