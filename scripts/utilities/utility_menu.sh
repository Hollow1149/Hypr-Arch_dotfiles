#!/bin/bash

if pgrep -x rofi >/dev/null; then
  pkill -x rofi
  exit 0
fi

rofi_cmd=(
  rofi
  -dmenu
  -theme "$HOME/.config/rofi/launcher-themes/utilitymenu.rasi"
  -i
  -markup
  -p "Utilities")

source "$HOME/.local/bin/myScripts/utilities/utility_functions.sh"

utilities=(
  "<b><span font='Font Awesome 7 Free' size='large'></span></b>  Screenshot"
  "<b><span font='Font Awesome 7 Free' size='large'></span></b>  ScreenRecord"
  "<b><span font='Font Awesome 7 Free' size='large'></span></b>  Hyprpicker"
  "<b><span font='Font Awesome 7 Free' size='large'></span></b>  Toggle Waybar ON/OFF"
  "<b><span font='Font Awesome 7 Free' size='large'></span></b>  System Stats"
  "<b><span font='Font Awesome 7 Free' size='large'></span></b>  Enable PowerTop (--auto-tune)"
  "<b><span font='Font Awesome 7 Free' size='large'></span></b>  Toggle Night Light"
  "<b><span font='Font Awesome 7 Free' size='large'></span></b>  Toggle Bluetooth ON/OFF"
)

choice=$(printf "%s\n" "${utilities[@]}" | "${rofi_cmd[@]}")

case "$choice" in
*Screenshot*)
  screenshot
  ;;
*ScreenRecord*)
  " "
  ;;
*Hyprpicker*)
  color_picker
  ;;
*Waybar*)
  toggle_waybar
  ;;
*"System Stats"*)
  system_statistics
  ;;
*PowerTop*)
  enable_powertop_powersaving
  ;;
*Night*)
  toggle_night_light
  ;;
*Bluetooth*)
  toggle_bluetooth
  ;;
esac
