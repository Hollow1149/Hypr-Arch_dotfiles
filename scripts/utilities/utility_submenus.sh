#!/bin/bash

screenshot_options=(
  "<b><span font='Font Awesome 7 Free' size='large'></span></b> Region"
  "<b><span font='Font Awesome 7 Free' size='large'></span></b> Window"
  "<b><span font='Font Awesome 7 Free' size='large'></span></b> Fullscreen"
  "<b><span font='Font Awesome 7 Free' size='large'></span></b> Smart"
  "<b><span font='Font Awesome 7 Free' size='large'>󱇣</span></b> Snap and Edit"
)

screenrecord_options=(
  "<b><span font='Font Awesome 7 Free' size='large'></span></b> Stop Recording"
  "No Audio and No Webcam      <b><span font='Font Awesome 7 Free' size='large'>  </span></b>"
  "With Desktop Audio          <b><span font='Font Awesome 7 Free' size='large'></span></b>"
  "With Desktop + Mic Audio    <b><span font='Font Awesome 7 Free' size='large'> </span></b>"
  "With Desktop + Mic + Webcam <b><span font='Font Awesome 7 Free' size='large'>  </span></b>"
)

shader_options=("Off")

shader_menu() {
  while IFS= read -r shader; do
    [[ -n "$shader" ]] && shader_options+=("$shader")
  done < <(hyprshade ls)

  shader_choice=$(printf "%s\n" "${shader_options[@]}" | sed 's/^[[:space:]]*//' | "${rofi_cmd[@]}")

  if [[ -z "$shader_choice" ]]; then
    exit 0
  fi

  shader_choice="${shader_choice//[*]/}"
  shader_choice="${shader_choice#"${shader_choice%%[![:space:]]*}"}"
  shader_choice="${shader_choice%"${shader_choice##*[![:space:]]}"}"

  current_shader=$(hyprshade current)

  if [[ "$shader_choice" == "Off" ]]; then
    hyprshade off
    hyprctl reload
  elif [[ "$shader_choice" == "$current_shader" ]]; then
    hyprshade off
    hyprctl reload
    notify-send -u normal "Damage Tracking Disabled"
  else
    hyprctl eval 'hl.config({ debug = { damage_tracking = 0} })'
    hyprshade on "$shader_choice"
    notify-send -u critical --icon dialog-error "Damage Tracking Enabled" "Turn off the shader using the 'off' option only."
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
