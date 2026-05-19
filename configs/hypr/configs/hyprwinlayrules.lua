--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Window-Rules for Applications
hl.window_rule({
	name = "float-thunar",
	match = { class = "thunar" },
	float = true,
	center = true,
	size = { "(monitor_w*0.6)", "(monitor_h*0.7)" },
})

hl.window_rule({
	name = "float-xdg-desktop-portal-gtk",
	match = { class = "xdg-desktop-portal-gtk" },
	float = true,
	center = true,
	size = { "(monitor_w*0.5)", "(monitor_h*0.7)" },
})

hl.window_rule({
	name = "float-gimp-submenus",
	match = { class = "script-fu", initial_class = "script-fu" },
	float = true,
	center = true,
	size = { "(monitor_w*0.4)", "(monitor_h*0.6)" },
})

hl.window_rule({
	name = "float-zen-download-menu",
	match = { title = "Library", initial_title = "Library" },
	float = true,
	center = true,
	size = { "(monitor_w*0.5)", "(monitor_h*0.7)" },
})

hl.window_rule({
	name = "float-zen-pip",
	match = { title = "Picture-in-Picture", initial_title = "Picture-in-Picture" },
	float = true,
	center = true,
	size = { "(monitor_w*0.3)", "(monitor_h*0.3)" },
	move = { 1342, 754 },
})

hl.window_rule({
	name = "float-abdownload-menu",
	match = { class = "com-abdownloadmanager-desktop-AppKt" },
	float = true,
	center = true,
})

hl.window_rule({
	name = "unfloat-abdownload-app",
	match = { class = "com-abdownloadmanager-desktop-AppKt", title = "AB Download Manager" },
	float = false,
})

hl.window_rule({
	name = "float-tor-launcher",
	match = { title = "Tor Browser Launcher Settings" },
	float = true,
	center = true,
	size = { "(monitor_w*0.3)", "(monitor_h*0.2)" },
})

hl.window_rule({
	name = "float-loupe",
	match = { initial_class = "org.gnome.Loupe" },
	float = true,
	center = true,
	size = { "(monitor_w*0.7)", "(monitor_h*0.8)" },
})

hl.window_rule({
	name = "float-Qalculate",
	match = { class = "qalculate-gtk", title = "Qalculate!" },
	float = true,
	center = true,
	size = { "(monitor_w*0.5)", "(monitor_h*0.7)" },
})

hl.window_rule({
	name = "float-mpv",
	match = { initial_class = "mpv" },
	float = true,
	center = true,
	size = { "(monitor_w*0.76)", "(monitor_h*0.76)" },
})

hl.window_rule({
	name = "float-zenity",
	match = { class = "zenity" },
	float = true,
})

hl.window_rule({
	name = "gimpWorkSpace3",
	match = { class = "gimp" },
	workspace = "3",
})

hl.window_rule({
	name = "zenWorkspace2",
	match = { class = "zen", initial_title = "Zen Browser" },
	workspace = "2",
})

hl.window_rule({
	name = "eden-less-deco",
	match = { class = "eden" },
	no_blur = true,
	no_shadow = true,
	opaque = true,
})

hl.window_rule({
	name = "float-satty",
	match = { initial_class = "com.gabm.satty" },
	float = true,
	center = true,
	size = { "(monitor_w*0.6)", "(monitor_h*0.7)" },
})

hl.window_rule({
	name = "pin-webcamOverlay",
	match = { title = "WebcamOverlay" },
	pin = true,
})

local pseudotileKitty = hl.window_rule({
	name = "pseudotile-kitty",
	match = { class = "kitty", title = "kitty" },
	pseudo = true,
	size = { "(monitor_w*0.9)", "(monitor_h*0.95)" },
})
pseudotileKitty:set_enabled(false)

hl.window_rule({
	name = "float-impala",
	match = { initial_title = "wifi-tui" },
	pin = true,
	float = true,
	center = true,
	stay_focused = true,
	size = { "(monitor_w*0.5)", "(monitor_h*0.6)" },
})

hl.window_rule({
	name = "float-bluetui",
	match = { initial_title = "bluetooth-tui" },
	pin = true,
	float = true,
	center = true,
	stay_focused = true,
	size = { "(monitor_w*0.5)", "(monitor_h*0.6)" },
})

hl.window_rule({
	name = "float-position-volume-control",
	match = { class = "org.pulseaudio.pavucontrol", title = "Volume Control" },
	pin = true,
	float = true,
	stay_focused = true,
	move = { 1342, 34 },
	size = { "(monitor_w*0.3)", "(monitor_h*0.4)" },
})

hl.window_rule({
	name = "float-position-networkEditor",
	match = { class = "nm-connection-editor", title = "Network Connections" },
	pin = true,
	float = true,
	stay_focused = true,
	move = { 1342, 34 },
	size = { "(monitor_w*0.3)", "(monitor_h*0.533)" },
})

hl.window_rule({
	name = "float-position-bluemon",
	match = { class = "blueman-manager", initial_class = "blueman-manager" },
	pin = true,
	float = true,
	stay_focused = true,
	move = { 1342, 34 },
	size = { "(monitor_w*0.3)", "(monitor_h*0.533)" },
})

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
suppressMaximizeRule:set_enabled(true)

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})

-------------------
--- Layer Rules ---
-------------------

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)
hl.layer_rule({
	match = { namespace = "waybar" },
	blur = true,
	ignore_alpha = 0.1,
})

hl.layer_rule({
	match = { namespace = "swaync-control-center" },
	blur = true,
	ignore_alpha = 0.2,
	animation = "slide right",
})

hl.layer_rule({
	match = { namespace = "swaync-notification-window" },
	blur = true,
	ignore_alpha = 0.2,
})

hl.layer_rule({
	match = { namespace = "rofi" },
	blur = true,
	ignore_alpha = 0.1,
})

hl.layer_rule({
	match = { namespace = "selection" },
	animation = "fadeIn",
})

hl.layer_rule({
	match = { namespace = "hyprpicker" },
	animation = "fadeIn",
})

hl.layer_rule({
	match = { namespace = "logout_dialog" },
	animation = "fadeIn",
})

-----------------------
--- Workspace-Rules ---
-----------------------

hl.workspace_rule({ workspace = "1", layout = "scrolling" })
hl.workspace_rule({ workspace = "special:magic", layout = "scrolling" })
