#!/bin/bash
#Script to take Screenshots

SAVE_DIR="$HOME/Pictures/Screenshots"
FILENAME="screenshot-$(date +'%Y%m%d-%H%M%S').png"
FULL_PATH="$SAVE_DIR/$FILENAME"

if [[ ! -d "$SAVE_DIR" ]]; then
  notify-send "Screenshot directory does not exist: $SAVE_DIR" -u critical -t 3000
  exit 1
fi

pkill slurp && exit 0

MODE="${1:-smart}"
PROCESSING="${2:-slurp -w 0 -d}"

get_rectangles() {
  local active_workspace=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .activeWorkspace.id')
  hyprctl monitors -j | jq -r --arg ws "$active_workspace" '.[] | select(.activeWorkspace.id == ($ws | tonumber)) | "\(.x),\(.y) \((.width / .scale) | floor)x\((.height / .scale) | floor)"'
  hyprctl clients -j | jq -r --arg ws "$active_workspace" '.[] | select(.workspace.id == ($ws | tonumber)) | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"'
}

# Screenshot modes
case "$MODE" in
region)
  hyprpicker -n -r -z -d &
  PICKER_PID=$!
  sleep 0.1
  SELECTION=$(slurp -w 0 -d 2>/dev/null)
  kill $PICKER_PID 2>/dev/null
  ;;
window)
  hyprpicker -n -r -z -d &
  PICKER_PID=$!
  sleep 0.1
  SELECTION=$(get_rectangles | slurp -w 0 -d -r 2>/dev/null)
  kill $PICKER_PID 2>/dev/null
  ;;
fullscreen)
  SELECTION=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | "\(.x),\(.y) \((.width / .scale) | floor)x\((.height / .scale) | floor)"')
  ;;
smart | *)
  RECTS=$(get_rectangles)
  hyprpicker -n -r -z -d &
  PICKER_PID=$!
  sleep 0.1
  SELECTION=$(echo "$RECTS" | slurp -w 0 -d 2>/dev/null)
  kill $PICKER_PID 2>/dev/null

  # If the selection area is L*W < 20, assume trying to select whichever window or output
  # it was inside of to prevent accidental 2px Screenshots
  if [[ "$SELECTION" =~ ^([0-9]+),([0-9]+)[[:space:]]([0-9]+)x([0-9]+)$ ]]; then
    if ((${BASH_REMATCH[3]} * ${BASH_REMATCH[4]} < 20)); then
      click_x="${BASH_REMATCH[1]}"
      click_y="${BASH_REMATCH[2]}"

      while IFS= read -r rect; do
        if [[ "$rect" =~ ^([0-9]+),([0-9]+)[[:space:]]([0-9]+)x([0-9]+) ]]; then
          rect_x="${BASH_REMATCH[1]}"
          rect_y="${BASH_REMATCH[2]}"
          rect_width="${BASH_REMATCH[3]}"
          rect_height="${BASH_REMATCH[4]}"

          if ((click_x >= rect_x && click_x < rect_x + rect_width && click_y >= rect_y && click_y < rect_y + rect_height)); then
            SELECTION="${rect_x},${rect_y} ${rect_width}x${rect_height}"
            break
          fi
        fi
      done <<<"$RECTS"
    fi
  fi
  ;;
esac

[ -z "$SELECTION" ] && exit 0

if [[ $PROCESSING == "slurp -w 0 -d" ]]; then
  grim -g "$SELECTION" - |
    satty --filename - \
      --output-filename "$FULL_PATH" \
      --early-exit \
      --actions-on-enter save-to-clipboard \
      --save-after-copy \
      --copy-command 'wl-copy'
  kill $PICKER_PID 2>/dev/null
else
  grim -g "$SELECTION" - | wl-copy
fi
