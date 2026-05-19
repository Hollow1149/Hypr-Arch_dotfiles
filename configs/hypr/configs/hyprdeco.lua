-----------------------
---- LOOK AND FEEL ----
-----------------------

local colors = require("configs/hyprcolor").colors

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
	general = {
		gaps_in = 3,
		gaps_out = 5,

		border_size = 0,

		col = {
			active_border = colors.primary,
			inactive_border = colors.outline_variant,
		},

		-- Set to true to enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = false,

		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing = false,

		layout = "dwindle",
	},

	decoration = {
		rounding = 10,
		rounding_power = 10,

		-- Change transparency of focused and unfocused windows
		active_opacity = 1.0,
		inactive_opacity = 0.9,
		dim_inactive = true,
		dim_strength = 0.1,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},

		blur = {
			enabled = true,
			size = 8,
			passes = 3,
			new_optimizations = true,
			ignore_opacity = true,
			xray = false,
			popups = true,
			vibrancy = 0.1696,
			noise = 0.0117,
		},
	},

	animations = {
		enabled = true,
	},
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("easeInSine", { type = "bezier", points = { { 0.12, 0 }, { 0.39, 0 } } })
hl.curve("easeOutSine", { type = "bezier", points = { { 0.61, 1 }, { 0.88, 1 } } })
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("easeOutBounce", { type = "bezier", points = { { 0.34, 1.56 }, { 0.64, 1 } } })
hl.curve("easeInQuart", { type = "bezier", points = { { 0.5, 0 }, { 0.75, 0 } } })
hl.curve("easeOutQuart", { type = "bezier", points = { { 0.165, 0.84 }, { 0.44, 1 } } })
hl.curve("easeInQuad", { type = "bezier", points = { { 0.11, 0 }, { 0.5, 0 } } })
hl.curve("easeOutQuad", { type = "bezier", points = { { 0.5, 1 }, { 0.89, 1 } } })
hl.curve("easeInOutQuad", { type = "bezier", points = { { 0.45, 0 }, { 0.55, 1 } } })
hl.curve("easeInExpo", { type = "bezier", points = { { 0.7, 0 }, { 0.84, 0 } } })
hl.curve("easeOutExpo", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })
hl.curve("easeInOutExpo", { type = "bezier", points = { { 0.87, 0 }, { 0.13, 1 } } })
hl.curve("easeInCirc", { type = "bezier", points = { { 0.55, 0 }, { 0.1, 0.45 } } })
hl.curve("easeOutCirc", { type = "bezier", points = { { 0, 0.55 }, { 0.45, 0.1 } } })
hl.curve("easeInOutCirc", { type = "bezier", points = { { 0.85, 0 }, { 0.15, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuart" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3.5, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 3.5, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "slide" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "easeOutQuart", style = "slidefade 50%" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 2.3, bezier = "easeInOutExpo", style = "slidefade 80%" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 2.5, bezier = "easeInOutExpo", style = "slidefade 80%" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
	dwindle = {
		preserve_split = true, -- You probably want this
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
	master = {
		new_status = "master",
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
	scrolling = {
		direction = "right",
		column_width = 0.8,
		follow_focus = true,
		follow_min_visible = 0.3,
		fullscreen_on_one_column = false,
	},
})

----------------
----  MISC  ----
----------------

hl.config({
	misc = {
		force_default_wallpaper = 0, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = true, -- If true disables the random hyprland logo / anime girl background. :(
		disable_splash_rendering = true,
		vrr = 2,
	},
})
