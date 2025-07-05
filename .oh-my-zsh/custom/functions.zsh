# Custom code command to open VS Code with workspace support
code() {
  TARGET_DIR="${1:-.}"
  WORKSPACE_FILE=$(find "$TARGET_DIR" -maxdepth 1 -type f -name '*.code-workspace' | head -n 1)

  # Check for Wayland session
  if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    CODE_CMD='ELECTRON_OZONE_PLATFORM_HINT=auto QT_QPA_PLATFORM=wayland code --enable-features=WaylandWindowDecorations --ozone-platform-hint=wayland'
  else
    # Fallback for X11 or unknown
    CODE_CMD='code'
  fi

  if [[ -n "$WORKSPACE_FILE" ]]; then
    eval "$CODE_CMD \"$WORKSPACE_FILE\""
  else
    eval "$CODE_CMD \"$TARGET_DIR\""
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
