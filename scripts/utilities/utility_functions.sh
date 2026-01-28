#!/bin/bash

source "$HOME/.local/bin/myScripts/utilities/utility_submenus.sh"

screenshot() {
  screenshot_menu
}

screenrecord() {
  screenrecord_menu
}

color_picker() {
  sleep 0.5 && hyprpicker -a -q >/dev/null
}

text_ocr() {
  sleep 0.5
  if ! pgrep tesseract >/dev/null; then
    OCR_TEXT="$(slurp | grim -g - - | tesseract stdin stdout -l eng)"

    if [[ -n "${OCR_TEXT//[[:space:]]/}" ]]; then
      printf "%s" "$OCR_TEXT" | wl-copy
      notify-send "Text Copied using OCR" "$OCR_TEXT"
    else
      notify-send "No Text Detected" "Nothing Copied to Clipboard"
    fi
  fi
}

toggle_waybar() {
  if pgrep -x waybar >/dev/null; then
    pkill -TERM waybar
    exit 0
  fi

  uwsm-app -- waybar &
  disown >/dev/null
}

system_statistics() {
  kitty -e btop >/dev/null
}

enable_powertop_powersaving() {
  pkexec powertop --auto-tune >/dev/null
}

toggle_night_light() {
  if pgrep -x hyprsunset >/dev/null; then
    pkill -x hyprsunset >/dev/null
    exit 0
  fi

  hyprsunset -t 4000 &
  disown >/dev/null
}

toggle_bluetooth() {
  status=$(bluetoothctl show | rg "Powered:" | awk '{print $2}')

  if [[ "$status" == "yes" ]]; then
    rfkill block bluetooth
    bluetoothctl power off
    notify-send "Bluetooth" "Disabled"
  else
    rfkill unblock bluetooth
    bluetoothctl power on >/dev/null
    notify-send "Bluetooth" "Enabled"
  fi
}
