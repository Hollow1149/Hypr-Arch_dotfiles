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
  "<b><span font='Font Awesome 7 Free' size='large'></span></b>  WiFi Menu"
  "<b><span font='Font Awesome 7 Free' size='large'></span></b>  Bluetooth Menu"
  "<b><span font='Font Awesome 7 Free' size='large'></span></b>  System Update"
  "<b><span font='Font Awesome 7 Free' size='large'></span></b>  Hyprctl Reload"
  "<b><span font='Font Awesome 7 Free' size='large'></span></b>  Screenshot"
  "<b><span font='Font Awesome 7 Free' size='large'></span></b>  ScreenRecord"
  "<b><span font='Font Awesome 7 Free' size='large'></span></b>  Hyprpicker"
  "<b><span font='Font Awesome 7 Free' size='large'></span></b>  Text OCR"
  "<b><span font='Font Awesome 7 Free' size='large'></span></b>  Shaders"
  "<b><span font='Font Awesome 7 Free' size='large'></span></b>  Toggle Waybar"
  "<b><span font='Font Awesome 7 Free' size='large'></span></b>  System Stats"
  "<b><span font='Font Awesome 7 Free' size='large'></span></b>  Enable PowerTop"
  "<b><span font='Font Awesome 7 Free' size='large'></span></b>  Toggle Night Light"
  "<b><span font='Font Awesome 7 Free' size='large'></span></b>  Toggle Bluetooth"
)

choice=$(printf "%s\n" "${utilities[@]}" | "${rofi_cmd[@]}")

case "$choice" in
*"WiFi Menu")
  wifi_menu
  ;;
*"Bluetooth Menu")
  bluetooth_menu
  ;;
*"System Update")
  system_update
  ;;
*"Hyprctl Reload")
  hyprctl_reload
  ;;
*"Screenshot")
  screenshot
  ;;
*"ScreenRecord")
  screenrecord
  ;;
*"Hyprpicker")
  color_picker
  ;;
*"Waybar")
  toggle_waybar
  ;;
*"OCR")
  text_ocr
  ;;
*"Shaders")
  shader_menu
  ;;
*"Stats")
  system_statistics
  ;;
*"PowerTop")
  enable_powertop_powersaving
  ;;
*"Light")
  toggle_night_light
  ;;
*"Bluetooth")
  toggle_bluetooth
  ;;
esac
