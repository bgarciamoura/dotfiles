local wezterm = require("wezterm")
local act = wezterm.action

-- Custom cyberpunk theme with soft neon colors
local cyberpunk_theme = {
	foreground = "#e0e0e0",
	background = "#0d1117",
	cursor_bg = "#ff2a6d",
	cursor_border = "#ff2a6d",
	cursor_fg = "#0d1117",
	selection_bg = "#3d5566",
	selection_fg = "#e0e0e0",

	ansi = {
		"#0d1117", -- Black
		"#ff2a6d", -- Red
		"#05d9e8", -- Green
		"#f9c80e", -- Yellow
		"#01c5c4", -- Blue
		"#b967ff", -- Magenta
		"#00feca", -- Cyan
		"#e0e0e0", -- White
	},

	brights = {
		"#2c333c", -- Bright Black
		"#ff6e96", -- Bright Red
		"#6bffe9", -- Bright Green
		"#fcdc4d", -- Bright Yellow
		"#67d7ee", -- Bright Blue
		"#d6afff", -- Bright Magenta
		"#64ffda", -- Bright Cyan
		"#ffffff", -- Bright White
	},
}

-- Tab styling is handled in events.lua via the format-tab-title event

-- Configuration for window frame
local window_frame = {
	font = wezterm.font({ family = "RobotoMono Nerd Font", weight = "Bold" }),
	font_size = 10.0,
	active_titlebar_bg = "#0d1117",
	inactive_titlebar_bg = "#0d1117",
}

-- Appearance configuration
return {
	-- Initial window size
	initial_rows = 50,
	initial_cols = 140,

	-- Font settings
	font = wezterm.font_with_fallback({
		{ family = "RobotoMono Nerd Font", weight = "Medium" },
		{ family = "JetBrainsMono Nerd Font", weight = "Medium" },
		{ family = "Symbols Nerd Font Mono", scale = 0.9 },
	}),
	font_size = 10,
	line_height = 1.1,

	-- Window appearance
	window_padding = {
		left = 5,
		right = 5,
		top = 5,
		bottom = 5,
	},
	window_background_opacity = 0.95,
	text_background_opacity = 1.0,
	window_decorations = "TITLE | RESIZE",
	window_frame = window_frame,

	-- Colors and themes
	color_scheme = "Catppuccin Mocha", -- Base theme
	colors = cyberpunk_theme, -- Uncomment to use custom theme

	-- Tab bar configuration
	enable_tab_bar = true,
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	tab_max_width = 25,
	show_tab_index_in_tab_bar = true,
	tab_bar_style = {
		new_tab = wezterm.format({
			{ Background = { Color = "#292e42" } },
			{ Foreground = { Color = "#a9b1d6" } },
			{ Text = " + " },
		}),
		new_tab_hover = wezterm.format({
			{ Background = { Color = "#3b4261" } },
			{ Foreground = { Color = "#7aa2f7" } },
			{ Text = " + " },
		}),
	},

	-- Tab format handled by the format-tab-title event in events.lua

	-- Background effects
	background = {
		{
			source = {
				File = wezterm.config_dir .. "/background.jpg",
			},
			width = "100%",
			height = "100%",
			opacity = 0.07,
		},
	},

	-- Cursor configuration
	default_cursor_style = "BlinkingBlock",
	cursor_thickness = 2,
}
