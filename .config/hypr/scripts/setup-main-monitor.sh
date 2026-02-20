#!/bin/bash
MONITOR_COUNT=$(hyprctl monitors all -j | jq '. | length')

if [ "$MONITOR_COUNT" -gt 1 ]; then
  hyprctl keyword monitor "eDP-1, disable"
else
  hyprctl keyword monitor "eDP-1, preferred, auto, 1"
fi
