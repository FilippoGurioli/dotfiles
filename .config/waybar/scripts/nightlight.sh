#!/usr/bin/env bash

STATE_FILE="$XDG_RUNTIME_DIR/nightlight.state"

# Toggle logic when clicked
if [ "$1" = "toggle" ]; then
  if [ -f "$STATE_FILE" ]; then
    pkill gammastep
    rm -f "$STATE_FILE"
  else
    gammastep -O 3500 &
    touch "$STATE_FILE"
  fi
  pkill -RTMIN+8 waybar
  exit 0
fi

# Reporting state to Waybar
if [ -f "$STATE_FILE" ] && pgrep -x "gammastep" >/dev/null; then
  echo '{"text": "󰌵", "tooltip": "Night Light: Active (3500K)", "class": "active"}'
else
  # Clean up state file if gammastep crashed/died unexpectedly
  rm -f "$STATE_FILE"
  echo '{"text": "󰌶", "tooltip": "Night Light: Off", "class": "inactive"}'
fi
