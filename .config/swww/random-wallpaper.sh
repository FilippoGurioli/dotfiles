#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/wallpapers"

# 1. Wait for awww-daemon to start up and respond
while ! awww query &>/dev/null; do
  sleep 0.1
done

# 2. Pick a random image file
RANDOM_WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp" \) | shuf -n 1)

# 3. Apply the random wallpaper
if [ -n "$RANDOM_WALLPAPER" ]; then
  awww img "$RANDOM_WALLPAPER" --filter Lanczos3 --transition-type outer --transition-step 90
fi
