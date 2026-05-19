----------------------------------------
--- Variables To use in config files ---
----------------------------------------

local variables = {}

variables.HOME = os.getenv("HOME")
variables.terminal = "uwsm-app -- kitty"
variables.fileManager = "uwsm-app -- thunar"
variables.menu = variables.HOME .. "/.local/bin/myScripts/utilities/menu_launcher.sh"
variables.clipboard = variables.HOME .. "/.local/bin/myScripts/clipboard/clipboard.sh"
variables.emojis = variables.HOME .. "/.local/bin/myScripts/utilities/emoji_launcher.sh"
variables.utilMenu = variables.HOME .. "/.local/bin/myScripts/utilities/utility_menu.sh"
variables.powerMenu = variables.HOME .. "/.local/bin/myScripts/wlogout/wlogout.sh"
variables.wallpaper = variables.HOME .. "/.local/bin/myScripts/wallpaperRelated/wallpaperSelect.sh"
variables.screenshot = variables.HOME .. "/.local/bin/myScripts/screenshots/screenshot.sh"

return variables
