#!/bin/bash

# Check if in the same workspace
is_terminal_active() {
  local terminal_ws
  local focused_workspace

  focused_workspace=$(hyprctl activewindow -j | jq -r '.workspace.id')
  terminal_ws=$(hyprctl clients -j | jq -r '.[] | select(.title=="System Update")  | .workspace.id')

  [[ "$focused_workspace" == "$terminal_ws" ]]
}

# Wait for user to be in the same workspace
wait_for_sudo_pass() {
  if ! is_terminal_active; then
    notify-send -u normal "Provide Sudo Password" "Sudo password required to continue updates"
  fi

  while ! is_terminal_active; do
    sleep 1
  done
}

export -f is_terminal_active
export -f wait_for_sudo_pass

update_npm() {
  export NVM_DIR="$HOME/.config/nvm"

  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

  npm -g upgrade
}

update_helper() {
  local title="$1"
  shift

  gum style --foreground=331 --border="hidden" --align="center" "$title"

  if "$@"; then
    gum style --foreground=331 --border="hidden" --align="center" "Done"
  else
    gum style --foreground="#ff6347" --border="hidden" --align="center" "Failed"
    return 1
  fi
}

sudo_update_helper() {
  local title="$1"
  shift

  gum style --foreground=331 --border="hidden" --align="center" "$title"

  if sudo "$@"; then
    gum style --foreground=331 --border="hidden" --align="center" "Done"
  else
    gum style --foreground="#ff6347" --border="hidden" --align="center" "Failed"
    return 1
  fi

}

start_updates() {

  local selected
  selected=$(gum choose --no-limit "pacman" "AUR" "auto-cpufreq" "npm" "rustup" "cargo" "uv" "ya(zi)" "oh-my-posh" "tldr")

  if [[ -z "$selected" ]]; then
    gum spin --spinner "globe" --title "Press any key to end..." -- bash -c "read -n 1 -s"
    exit 0
  fi

  if [[ $selected == *pacman* || $selected == *auto-cpufreq* ]]; then
    gum spin --spinner "dot" --show-error --title "Waiting for focus..." -- bash -c wait_for_sudo_pass
    gum style --foreground="#90ee90" --border="hidden" --align="center" "Authenticate sudo"

    if ! sudo -v; then
      gum style --foreground="#ff6347" --border="hidden" --align="center" "Authentication Failed"
      return 1
    fi
  fi
  gum spin --spinner "dot" --show-output --align "left" --title "Starting Update/s" -- bash -c "sleep 1"

  if [[ $selected == *pacman* ]]; then
    sudo_update_helper "Updating System Packages" pacman -Syu
  fi

  if [[ $selected == *AUR* ]]; then
    update_helper "Updating AUR packages" yay -Sua
  fi

  if [[ $selected == *auto-cpufreq* ]]; then
    sudo_update_helper "Updating auto-cpufreq" auto-cpufreq --update
  fi

  if [[ $selected == *npm* ]]; then
    update_helper "Updating npm packages" update_npm
  fi

  if [[ $selected == *rustup* ]]; then
    update_helper "Updating rust toolchain installer" rustup update
  fi

  if [[ $selected == *cargo* ]]; then
    update_helper "Updating cargo packages" cargo install-update -a
  fi

  if [[ $selected == *uv* ]]; then
    update_helper "Updating uv tool packages" uv tool upgrade --all
  fi

  if [[ $selected == *ya\(zi\)* ]]; then
    update_helper "Updating ya packages" ya pkg upgrade
  fi

  if [[ $selected == *oh-my-posh* ]]; then
    update_helper "Updating oh-my-posh" oh-my-posh upgrade
  fi

  if [[ $selected == *tldr* ]]; then
    update_helper "Updating tldr local database" tldr --update
  fi

  gum spin --spinner "globe" --title "System Update Complete. Press any key to end..." -- bash -c "read -n 1 -s"
}

update_checker() {
  local avail_updates
  local choice
  avail_updates=$({
    gum spin --spinner "dot" --show-output --title "Checking for pacman updates..." -- checkupdates
    echo
    gum spin --spinner "dot" --show-output --title "Checking for AUR updates..." -- yay -Qua
  })
  if [[ -z $avail_updates ]]; then
    gum style --foreground="#90ee90" --border="hidden" --align="center" "System is up to date"
    gum spin --spinner "moon" --title "Press any key to exit..." -- bash -c "read -n 1 -s"
    exit 0
  fi

  gum style --foreground="#90ee90" --border="hidden" --align="center" "$avail_updates"
  choice=$(gum choose --limit=1 --header="Would you like to update your system?" "Yes" "No")
  if [[ $choice == "Yes" ]]; then
    start_updates
  elif [[ $choice == "No" ]]; then
    gum spin --spinner "moon" --title "Press any key to exit..." -- bash -c "read -n 1 -s"
    exit 0
  fi
}

option=$(gum choose --limit=1 "Check for Updates" "Update System")

case "$option" in
"Check for Updates")
  update_checker
  ;;
"Update System")
  start_updates
  ;;
esac
