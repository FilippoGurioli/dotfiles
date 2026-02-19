#!/bin/bash
if pgrep -x wf-recorder >/dev/null; then
  echo '{"text": "⏺ REC", "class": "recording", "tooltip": "Screen recording in progress"}'
fi
