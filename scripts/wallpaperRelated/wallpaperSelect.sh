#!/usr/bin/env bash
# For Hyprland + swww

# === CONFIGURATION ===
# Directories
wallpaperDir="$HOME/Pictures/Wallpapers"
themesDir="$HOME/.config/rofi/launcher-themes/"
cacheDir="$HOME/.cache/wallpaper-selector"
listCache="$cacheDir/wallpaper_list.txt"
thumbDir="$cacheDir/thumbnails"

mkdir -p "$thumbDir"

# Transition settings
FPS=60
TYPE="any"
DURATION=1.5
BEZIER="0.4,0.2,0.4,1.0"
SWWW_PARAMS=(--transition-fps "${FPS}" --transition-type "${TYPE}" --transition-duration "${DURATION}" --transition-bezier "${BEZIER}")

# Thumbnail generation
generate_thumbnail() {
  while read -r pic; do
    if [[ "$pic" != *.gif ]]; then
      filename="$(basename "$pic")"
      thumb="$thumbDir/${filename}.png"
      [[ ! -f "$thumb" ]] && convert "$pic" -resize 500 "$thumb" 2>/dev/null
    else
      # For GIFs, create a thumbnail from the first frame
      filename="$(basename "$pic")"
      thumb="$thumbDir/${filename}.png"
      [[ ! -f "$thumb" ]] && convert "$pic[0]" -resize 500 "$thumb" 2>/dev/null
    fi
  done <"$listCache"
}

# === COLLECT WALLPAPERS ===
if [[ ! -f "$listCache" || $(find "$wallpaperDir" -type f -newer "$listCache" | wc -l) -gt 0 ]]; then
  find -L "$wallpaperDir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) | sort >"$listCache"

  generate_thumbnail &
fi

# Remove thumbnail for non-existent wallpaper
if [[ -f "$listCache" ]]; then
  find "$thumbDir" -name "*.png" | while read -r thumb; do
    thumb_name=$(basename "$thumb" .png)
    if ! grep -q "$thumb_name" "$listCache"; then
      rm -rf "$thumb"
    fi
  done
fi

mapfile -t PICS <"$listCache"

# Random wallpaper logic
randomPreviewImage="$HOME/Pictures/Others/.question_unown.png"
randomNumber=$(((RANDOM + $(date +%s) + $$) % ${#PICS[@]}))
randomPicture="${PICS[$randomNumber]}"
randomChoice="[${#PICS[@]}] Random"

# Rofi command
rofiCommand="rofi -show -dmenu -theme ${themesDir}/wallpaper-select.rasi"

# === DISPLAY ROFI MENU ===
menu() {
  # Generate menu entries
  printf "%s\x00icon\x1f%s\n" "$randomChoice" "$randomPreviewImage"
  for pic in "${PICS[@]}"; do
    filename="$(basename "$pic")"
    name="${filename%.*}"

    thumb="$thumbDir/${filename}.png"
    printf "%s\x00icon\x1f%s\n" "$name" "$thumb"
  done
}

# === WALLPAPER SETTER ===
executeCommand() {
  swww img "$1" "${SWWW_PARAMS[@]}"
  ln -sf "$1" "${wallpaperDir}/current_wallpaper"

  if command -v wallust &>/dev/null; then
    if ! WALLUST_OUTPUT=$(wallust run "$1" 2>&1); then
      notify-send -u low "⚠️ Wallust encountered an error: $WALLUST_OUTPUT"
    fi

    killall waybar 2>/dev/null

    while pgrep -x waybar >/dev/null; do
      sleep 0.1
    done

    waybar &

    if command -v swaync-client &>/dev/null; then
      swaync-client -R -rs
    fi
  else
    notify-send -u critical "Wallust is not installed."
  fi

}

# === MAIN FUNCTION ===
main() {
  choice=$(menu | $rofiCommand)

  [[ -z "$choice" ]] && exit 0

  if [[ "$choice" == "$randomChoice" ]]; then
    executeCommand "$randomPicture"
    exit 0
  fi

  for file in "${PICS[@]}"; do
    filename=$(basename "$file")
    if [[ "${filename%.*}" == "$choice" ]]; then
      executeCommand "$file"
      exit 0
    fi
  done

  notify-send -u critical "❌ Selected image not found."
  exit 1
}

# === KILL RUNNING ROFI IF OPEN ===
if pidof rofi 2>/dev/null; then
  pkill rofi
  exit 0
fi

# === START SCRIPT ===
main
