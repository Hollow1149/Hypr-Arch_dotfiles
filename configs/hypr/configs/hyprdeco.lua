-----------------------
---- LOOK AND FEEL ----
-----------------------

local colors = require("configs/hyprcolor").colors

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
	general = {
		gaps_in = 3,
		gaps_out = 3,

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
			enabled = false,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},

		blur = {
			enabled = true,
			size = 6,
			passes = 4,
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
hl.curve("easeOutCubic", { type = "bezier", points = { { 0.33, 1 }, { 0.68, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("easeOutBounce", { type = "bezier", points = { { 0.34, 1.56 }, { 0.64, 0.8 } } })
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
hl.curve("experiment", { type = "spring", mass = 1, stiffness = 350, dampening = 25 })
hl.curve("appleDefault", { type = "spring", mass = 1, stiffness = 600, dampening = 35 })
hl.curve("appleSmooth", { type = "spring", mass = 1, stiffness = 483.6, dampening = 41.5 })
hl.curve("materialNoBounce", { type = "spring", mass = 1, stiffness = 200, dampening = 28.3 })
hl.curve("materialBouncy", { type = "spring", mass = 1, stiffness = 1500, dampening = 38.7 })
hl.curve("reactDefault", { type = "spring", mass = 1, stiffness = 550, dampening = 45 })
hl.curve("reactWobbly", { type = "spring", mass = 1, stiffness = 180, dampening = 12 })
hl.curve("reactGentle", { type = "spring", mass = 1, stiffness = 120, dampening = 14 })
hl.curve("reactStiff", { type = "spring", mass = 1, stiffness = 410, dampening = 28 })
hl.curve("reactSlow", { type = "spring", mass = 1, stiffness = 280, dampening = 60 })
hl.curve("reactMolasses", { type = "spring", mass = 1, stiffness = 280, dampening = 120 })
hl.curve("framerDefault", { type = "spring", mass = 1, stiffness = 100, dampening = 10 })
hl.curve("crispSnap", { type = "spring", mass = 1, stiffness = 300, dampening = 34.6 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 2.5, bezier = "easeOutQuart" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 1, spring = "appleDefault", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.5, spring = "crispSnap", style = "popin 87%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 2.6, spring = "reactDefault" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "quick" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.7, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.5, bezier = "almostLinear" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.8, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 3.5, spring = "reactStiff", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, spring = "materialNoBounce", style = "slide" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.8, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.4, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "easeOutQuart", style = "slidefade 50%" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 2.3, bezier = "easeOutCubic", style = "slidefade 80%" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 2.5, bezier = "easeInOutCubic", style = "slidefade 80%" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 3.5, bezier = "quick" })

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
		wrap_focus = true,
		column_width = 0.9,
		follow_focus = true,
		focus_fit_method = 1,
		follow_min_visible = 0.3,
		fullscreen_on_one_column = false,
	},
})
