#!/bin/bash

DIRECTION=$1
ACTIVE_WS=$(hyprctl activeworkspace -j | jq '.id')
LAYOUT=$(hyprctl activewindow -j | jq -r '.workspace.id')

# Try to move focus
hyprctl dispatch focuswindow "$DIRECTION"

# Wait a tiny bit
sleep 0.05

# Check if the window changed
NEW_WS=$(hyprctl activeworkspace -j | jq '.id')

if [[ "$NEW_WS" == "$ACTIVE_WS" ]]; then
    if [ "$DIRECTION" = "r" ]; then
        hyprctl dispatch workspace e+1
    else
        hyprctl dispatch workspace e-1
    fi
fi
