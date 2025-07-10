#!/bin/bash

DIRECTION=$1
WINDOW_POS=$(hyprctl activewindow -j | jq -r '.at[0]')

# Try to move focus
hyprctl dispatch movefocus "$DIRECTION"

# Wait a tiny bit
sleep 0.05

NEW_WINDOW_POS=$(hyprctl activewindow -j | jq -r '.at[0]')
# Check if the window changed
if [[ "$DIRECTION" == "l" && $NEW_WINDOW_POS -ge $WINDOW_POS ]]; then
    hyprctl dispatch workspace e-1
elif [[ "$DIRECTION" == "r" && $NEW_WINDOW_POS -le $WINDOW_POS ]]; then
    hyprctl dispatch workspace e+1
fi