#!/bin/bash
# Script to take Screenshots of a region using grim + slurp

SAVE_DIR="$HOME/Pictures/Screenshots"
FILENAME="screenshot-$(date +'%Y%m%d-%H%M%S').png"
FULL_PATH="$SAVE_DIR/$FILENAME"

mkdir -p "$SAVE_DIR" || {
  notify-send -u critical "Error" "Failed to create directory $SAVE_DIR."
  exit 1
}

hyprpicker -n -r -z -d &
PICKER_PID=$!

sleep 0.1

grim -g "$(slurp -w 0 -d 2>/dev/null)" "$FULL_PATH"
SLURP_STATUS=$?

kill $PICKER_PID 2>/dev/null

if [ $SLURP_STATUS -ne 0 ]; then
  exit 0
fi

if [ -f "$FULL_PATH" ]; then
  wl-copy <"$FULL_PATH" &&
    notify-send -i "$FULL_PATH" "📸 Screenshot Taken" "$FILENAME copied to clipboard."
else
  notify-send -u critical "Error" "Failed to capture screenshot."
  exit 1
fi
