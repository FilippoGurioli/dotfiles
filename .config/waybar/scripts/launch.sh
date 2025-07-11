#!/bin/bash

killall -9 waybar

# recompile the stylesheets
~/.config/themer/update-theme.sh

waybar &