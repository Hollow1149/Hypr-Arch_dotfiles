#!/bin/bash

screenshot_options=(
  "<b><span font='Font Awesome 7 Free' size='large'></span></b> Region"
  "<b><span font='Font Awesome 7 Free' size='large'></span></b> Window"
  "<b><span font='Font Awesome 7 Free' size='large'></span></b> Fullscreen"
  "<b><span font='Font Awesome 7 Free' size='large'></span></b> Smart"
  "<b><span font='Font Awesome 7 Free' size='large'>󱇣</span></b> Snap and Edit"
)

screenrecord_options=(
  "No Audio and No Webcam      <b><span font='Font Awesome 7 Free' size='large'>  </span></b>"
  "With Desktop Audio          <b><span font='Font Awesome 7 Free' size='large'></span></b>"
  "With Desktop + Mic Audio    <b><span font='Font Awesome 7 Free' size='large'> </span></b>"
  "With Desktop + Mic + Webcam <b><span font='Font Awesome 7 Free' size='large'>  </span></b>"
  "<b><span font='Font Awesome 7 Free' size='large'></span></b> Stop Recording"
)

shader_options=("Off")

shader_menu() {
  while IFS= read -r shader; do
    [[ -n "$shader" ]] && shader_options+=("$shader")
  done < <(hyprshade ls)

  shader_choice=$(printf "%s\n" "${shader_options[@]}" | sed 's/^[[:space:]]*//' | "${rofi_cmd[@]}")

  echo "$shader_choice"

  if [[ -z "$shader_choice" ]]; then
    exit 0
  fi

  if [[ "$shader_choice" == "Off" ]]; then
    hyprshade off
    hyprctl reload
  else
    hyprctl reload
    hyprshade on "$shader_choice"
  fi
}

screenshot_menu() {
  screenshot_choice=$(printf "%s\n" "${screenshot_options[@]}" | "${rofi_cmd[@]}")

  case "$screenshot_choice" in
  *"Region")
    sleep 0.5 &&
      "$HOME/.local/bin/myScripts/screenshots/screenshot.sh" --region
    ;;
  "*Window")
    sleep 0.5 &&
      "$HOME/.local/bin/myScripts/screenshots/screenshot.sh" --window
    ;;
  *"Fullscreen")
    sleep 0.5 &&
      "$HOME/.local/bin/myScripts/screenshots/screenshot.sh" --fullscreen
    ;;
  *"Smart")
    sleep 0.5 &&
      "$HOME/.local/bin/myScripts/screenshots/screenshot.sh" --smart
    ;;
  *"Snap and Edit")
    sleep 0.5 &&
      "$HOME/.local/bin/myScripts/screenshots/screenshot.sh" --smart --edit
    ;;
  esac
}

screenrecord_menu() {
  screenrecord_choice=$(printf "%s\n" "${screenrecord_options[@]}" | "${rofi_cmd[@]}")

  case "$screenrecord_choice" in
  "No Audio and No Webcam"*)
    sleep 0.5 &&
      "$HOME/.local/bin/myScripts/screenshots/screenrecord.sh"
    ;;
  "With Desktop Audio"*)
    sleep 0.5 &&
      "$HOME/.local/bin/myScripts/screenshots/screenrecord.sh" --with-desktop-audio
    ;;
  "With Desktop + Mic Audio"*)
    sleep 0.5 &&
      "$HOME/.local/bin/myScripts/screenshots/screenrecord.sh" --with-desktop-audio --with-microphone-audio
    ;;
  "With Desktop + Mic + Webcam"*)
    sleep 0.5 &&
      "$HOME/.local/bin/myScripts/screenshots/screenrecord.sh" --with-desktop-audio --with-microphone-audio --with-webcam
    ;;
  *"Stop Recording")
    sleep 0.5 &&
      "$HOME/.local/bin/myScripts/screenshots/screenrecord.sh" --stop-recording
    ;;
  esac
}
