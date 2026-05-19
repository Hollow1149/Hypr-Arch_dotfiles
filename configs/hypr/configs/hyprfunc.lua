------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
	output = "eDP-1",
	mode = "preferred",
	position = "auto",
	scale = "1",
})

-----------------
--- Variables ---
-----------------
local vars = require("configs.hyprvars")

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:

hl.on("hyprland.start", function()
	hl.exec_cmd("uwsm-app -- awww-daemon")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("uwsm-app -- wl-paste --type text --watch cliphist store") -- Stores only Text data
	hl.exec_cmd("uwsm-app -- wl-paste --type image --watch cliphist store") -- Stores only Image data
	hl.exec_cmd("uwsm-app -- mpd")
	hl.exec_cmd("uwsm-app -- mpDris2")
	hl.exec_cmd("uwsm-app -- waybar")
end)
--
-- hl.on("hyprland.start", function ()
--   hl.exec_cmd(terminal)
--   hl.exec_cmd("nm-applet")
--   hl.exec_cmd("waybar & hyprpaper & firefox")
-- end)

---------------
---- INPUT ----
---------------

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "caps:swapescape",
		kb_rules = "",

		follow_mouse = 1,

		accel_profile = "flat",
		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

		touchpad = {
			natural_scroll = false,
		},
	},
})

----------------
--- Gestures ---
----------------

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

local app_menu = function()
	hl.exec_cmd(vars.HOME .. "/.local/bin/myScripts/utilities/menu_launcher.sh")
end

hl.gesture({
	fingers = 3,
	direction = "up",
	action = app_menu,
})

hl.gesture({
	fingers = 3,
	direction = "down",
	action = "resize",
})

hl.gesture({
	fingers = 2,
	direction = "pinch",
	action = "cursor_zoom",
	zoom_level = 1,
	mode = "live",
})

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")
--
-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
-- hl.env("XCURSOR_SIZE","27")
-- hl.env("HYPRCURSOR_SIZE","27")
-- hl.env("XDG_SESSION_TYPE","wayland")
-- hl.evn("XDG_CURRENT_DESTOP","Hyprland")
-- hl.env("XDG_SESSION_DESKTOP","Hyprland")
-- hl.env("XCURSOR_THEME","BreezeX-RosePine-Linux")
-- hl.env("HYPRCURSOR_THEME", "rose"-pine-hyprcursor)

-- -------------------------------------------
-- --- Rules to make apps work with NVIDIA ---
-- -------------------------------------------

-- Environment-variables needed for Nvidia GPU
-- env = LIBVA_DRIVER_NAME, nvidia
-- env = __GLX_VENDOR_LIBRARY_NAME, nvidia

-- To enable native Wayland support for most electron apps
-- hl.env("ELECTORN_OZONE_PLATFORM_HINT", "auto")

-- To enable hardware video acceleration
-- hl.env("NVD_BACKEND","direct")
