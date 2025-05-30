# Custom code command to open VS Code with workspace support
code() {
  TARGET_DIR="${1:-.}"
  # Find a .code-workspace file in the directory (only one, prefer exact match)
  WORKSPACE_FILE=$(find "$TARGET_DIR" -maxdepth 1 -type f -name '*.code-workspace' | head -n 1)
  if [[ -n "$WORKSPACE_FILE" ]]; then
    # Open the workspace files
    command code "$WORKSPACE_FILE"
  else
    # No workspace found, open the directory as-is
    command code "$TARGET_DIR"
  fi
}

# Funny function to play a sound and clear the terminal
# Requires a sound file named 'roomba.wav' in ~/Music
brrrr() {
  ( aplay -c 2 -f u8 -r 44100 ~/Music/roomba.wav & ) &> /dev/null
  for (( i=1; i<=$(tput lines); i++ )) do
    tput cup $(( $(tput lines) - $i )) 0 && tput ed
    sleep 0.05
  done
  clear
}