#!/bin/bash
# Script to take Screenshots of full screen using grim + slurp

SAVE_DIR="$HOME/Pictures/Screenshots"
FILENAME="screenshot-$(date +'%Y%m%d-%H%M%S').png"
FULL_PATH="$SAVE_DIR/$FILENAME"

mkdir -p "$SAVE_DIR" || {
  notify-send -u critical "Error" "Failed to create directory $SAVE_DIR"
  exit 1
}

grim "$FULL_PATH"
GRIM_STATUS=$?

if [ $GRIM_STATUS -eq 0 ] && [ -f "$FULL_PATH" ]; then
  wl-copy <"$FULL_PATH" &&
    notify-send -i "$FULL_PATH" "🖥️ Fullscreen Screenshot Taken" "$FILENAME copied to clipboard."
else
  notify-send -u critical "Error" "Failed to capture screeshot."
  exit 1
fi
