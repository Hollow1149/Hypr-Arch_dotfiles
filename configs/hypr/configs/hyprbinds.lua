---------------------
---- KEYBINDINGS ----
---------------------

-----------------
--- Variables ---
-----------------
local vars = require("configs.hyprvars")
local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Per Layout Bindings
local function layout_bind(bind_table)
	return function()
		local workspace = hl.get_active_special_workspace() or hl.get_active_workspace()
		if not workspace then
			return
		end

		local layout = workspace.tiled_layout

		if bind_table[layout] then
			hl.dispatch(bind_table[layout])
		end
	end
end

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(vars.terminal))
hl.bind(mainMod .. " + N", hl.dsp.window.close()) -- nuke a program
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(vars.menu))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(vars.fileManager))
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(
	mainMod .. " + O",
	layout_bind({
		dwindle = hl.dsp.layout("togglesplit"),
	})
)
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(vars.clipboard))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(vars.emojis))
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("uwsm-app -- hyprlock")) -- isolate
hl.bind(mainMod .. " + U", hl.dsp.exec_cmd(vars.utilMenu))
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd(vars.screenshot .. " --smart"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(vars.wallpaper .. " --menu"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(vars.wallpaper .. " --random"))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen("fullscreen", "toggle"))

-- Open wlogout menu
hl.bind("ALT + F4", hl.dsp.exec_cmd(vars.powerMenu))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Move and Resize Windows
hl.bind(mainMod .. " + ALT + K", hl.dsp.window.resize({ x = 0, y = -25, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + J", hl.dsp.window.resize({ x = 0, y = 25, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + H", hl.dsp.window.resize({ x = -25, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + L", hl.dsp.window.resize({ x = 25, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

-- Move and Resize Windows in Scrolling Layout
hl.bind(
	mainMod .. " + SHIFT + period",
	layout_bind({
		scrolling = hl.dsp.layout("swapcol r"),
	})
)
hl.bind(
	mainMod .. " + SHIFT + comma",
	layout_bind({
		scrolling = hl.dsp.layout("swapcol l"),
	})
)
hl.bind(
	mainMod .. " + ALT + period",
	layout_bind({
		scrolling = hl.dsp.layout("colresize +0.05"),
	}),
	{ repeating = true }
)
hl.bind(
	mainMod .. " + ALT + comma",
	layout_bind({
		scrolling = hl.dsp.layout("colresize -0.05"),
	}),
	{ repeating = true }
)
hl.bind(
	mainMod .. " + bracketleft",
	layout_bind({
		scrolling = hl.dsp.layout("consume_or_expel prev"),
	})
)
hl.bind(
	mainMod .. " + bracketright",
	layout_bind({
		scrolling = hl.dsp.layout("consume_or_expel next"),
	})
)

-- Move Windows in Scrolling and Monocle Layout
hl.bind(
	mainMod .. " + comma",
	layout_bind({
		scrolling = hl.dsp.layout("move -col"),
		monocle = hl.dsp.layout("cycleprev"),
	})
)

hl.bind(
	mainMod .. " + period",
	layout_bind({
		scrolling = hl.dsp.layout("move +col"),
		monocle = hl.dsp.layout("cyclenext"),
	})
)

-- Cursor Zoom
local MAX_ZOOM = 10
local MIN_ZOOM = 1
local ZOOM_TOGGLE_FACTOR = 1.5

--@param offset number
--@return nil
local function zoom(offset)
	local current = hl.get_config("cursor.zoom_factor")
	if offset ~= nil then
		current = current + offset
	elseif current ~= MIN_ZOOM then
		current = MIN_ZOOM
	else
		current = ZOOM_TOGGLE_FACTOR
	end
	current = math.max(MIN_ZOOM, math.min(MAX_ZOOM, current))
	hl.config({ cursor = { zoom_factor = current } })
end

hl.bind(mainMod .. " + Z", zoom)
hl.bind(mainMod .. " + equal", function()
	zoom(0.25)
end, { repeating = true })

hl.bind(mainMod .. " + minus", function()
	zoom(-0.25)
end, { repeating = true })

-- Gaming
hl.bind(mainMod .. " + G", hl.dsp.focus({ workspace = "name:gaming" }))
hl.bind(mainMod .. " + SHIFT + G", hl.dsp.window.move({ workspace = "name:gaming" }))

-- Enable Focus Mode/ Game Mode/ Battery Saving Mode
hl.bind(mainMod .. " + ALT + G", function()
	local game_mode = (hl.get_config("animations.enabled") == false)

	if game_mode then
		hl.exec_cmd("hyprctl reload")
		return
	end

	hl.config({
		general = {
			gaps_in = 0,
			gaps_out = 0,
			border_size = 0,
		},

		animations = {
			enabled = false,
		},

		decoration = {
			shadow = { enabled = false },
			blur = { enabled = false },
			rounding = 0,
		},
	})
end)

-- Switch/Cycle Layouts for current workspace
hl.bind(mainMod .. " + tab", function()
	local layouts = { "scrolling", "dwindle", "master", "monocle" }
	local workspace = hl.get_active_workspace()

	if hl.get_active_special_workspace() then
		workspace = hl.get_active_special_workspace()
	end

	local next_layout = "dwindle"

	if not workspace then
		return
	end

	for i = 1, #layouts do
		if layouts[i] == workspace.tiled_layout then
			local next_layout_idx = (i % #layouts) + 1
			next_layout = layouts[next_layout_idx]
			break
		end
	end

	if workspace.special then
		hl.workspace_rule({ workspace = tostring(workspace.name), layout = next_layout })
	else
		hl.workspace_rule({ workspace = tostring(workspace.id), layout = next_layout })
	end
end)

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
