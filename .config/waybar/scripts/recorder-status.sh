#!/bin/bash
if pgrep wf-recorder >/dev/null; then
  echo "{\"text\": \"⏺ REC\", \"tooltip\": \"Screen recording in progress\"}"
else
  echo "{\"text\": \"\"}"
fi
