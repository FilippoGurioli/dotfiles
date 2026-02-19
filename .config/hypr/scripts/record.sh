#!/bin/bash
FILE=~/Videos/Screencasts/recording_$(date +%Y-%m-%d_%H-%M-%S).mp4
wf-recorder -g "$(slurp)" --codec=h264_vaapi -f "$FILE"
notify-send "Screen Recording" "Saved to $FILE" --icon=video-x-generic
