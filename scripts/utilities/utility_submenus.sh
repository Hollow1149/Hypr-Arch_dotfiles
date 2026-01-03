#!/bin/bash

screenshot_options=(
  "<b><span font='Font Awesome 7 Free' size='large'></span></b> Region"
  "<b><span font='Font Awesome 7 Free' size='large'></span></b> Window"
  "<b><span font='Font Awesome 7 Free' size='large'></span></b> Fullscreen"
  "<b><span font='Font Awesome 7 Free' size='large'></span></b> Smart"
  "<b><span font='Font Awesome 7 Free' size='large'>󱇣</span></b> Snap and Edit"
)

screenshot_menu() {
  screenshot_choice=$(printf "%s\n" "${screenshot_options[@]}" | "${rofi_cmd[@]}")

  case "$screenshot_choice" in
  *Region*)
    sleep 0.5 &&
      "$HOME/.local/bin/myScripts/screenshots/screenshot.sh" --region
    ;;
  *Window*)
    sleep 0.5 &&
      "$HOME/.local/bin/myScripts/screenshots/screenshot.sh" --window
    ;;
  *Fullscreen*)
    sleep 0.5 &&
      "$HOME/.local/bin/myScripts/screenshots/screenshot.sh" --fullscreen
    ;;
  *Smart*)
    sleep 0.5 &&
      "$HOME/.local/bin/myScripts/screenshots/screenshot.sh" --smart
    ;;
  *"Snap and Edit"*)
    sleep 0.5 &&
      "$HOME/.local/bin/myScripts/screenshots/screenshot.sh" --smart --edit
    ;;
  esac
}
