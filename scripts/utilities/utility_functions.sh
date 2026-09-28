#!/bin/bash

source "$HOME/.local/bin/myScripts/utilities/utility_submenus.sh"

wifi_menu() {
  kitty --title "wifi-tui" wlctl
}

bluetooth_menu() {
  status=$(rfkill -J | jq -r '.rfkilldevices[] | select(.device=="hci0") | .soft')

  case "$status" in
  "unblocked")
    kitty --title "bluetooth-tui" bluetui
    ;;
  "blocked")
    rfkill unblock bluetooth
    notify-send "Bluetooth" "Enabled"
    sleep 0.2
    kitty --title "bluetooth-tui" bluetui
    ;;
  esac
}

system_update() {
  kitty -T "System Update" "$HOME/.local/bin/myScripts/utilities/system_updater.sh"
}

hyprctl_reload() {
  hyprctl reload

  notify-send -u normal --icon reload "Hyprland Config Reloaded"

}

screenshot() {
  screenshot_menu
}

screenrecord() {
  screenrecord_menu
}

color_picker() {
  sleep 0.5 && hyprpicker -a -q >/dev/null
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

toggle_bluetooth() {
  status=$(rfkill -J | jq -r '.rfkilldevices[] | select(.device=="hci0") | .soft')

  case "$status" in
  "unblocked")
    rfkill block bluetooth
    notify-send "Bluetooth" "Disabled"
    ;;
  "blocked")
    rfkill unblock bluetooth
    notify-send "Bluetooth" "Enabled"
    ;;
  esac
}
