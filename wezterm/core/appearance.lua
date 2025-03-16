return function(config, wezterm)
	-- ==============
	-- ==   FONTE  ==
	-- ==============
	config.font = wezterm.font_with_fallback({
		{
			family = "Maple Mono NF",
			weight = "Regular",
			style = "Normal",
		},
		{
			family = "IosevkaTerm Nerd Font",
			weight = "Regular",
			style = "Normal",
		},
		{
			family = "Symbols Nerd Font",
			weight = "Regular",
			style = "Normal",
		},
		{
			family = "FiraCode Nerd Font",
			weight = "Regular",
			style = "Normal",
		},
	})
	config.font_size = 13.0

	-- Ligaduras (se sua fonte suportar e você gostar)
	config.harfbuzz_features = { "calt=0", "ss01=1", "ss02=1", "ss03=1", "ss04=1", "ss05=1", "ss06=1" }

	-- ==============
	-- ==   TEMA   ==
	-- ==============
	-- https://wezfurlong.org/wezterm/colorschemes/index.html
	config.color_scheme = "Kanagawa (Gogh)"

	-- ==============
	-- == JANELA   ==
	-- ==============
	config.window_background_opacity = 0.90
	config.window_decorations = "RESIZE | TITLE"
	config.enable_tab_bar = true -- Mostrar ou não a barra de abas
	config.use_fancy_tab_bar = false
	config.hide_tab_bar_if_only_one_tab = true
	config.tab_max_width = 26
	config.window_frame = {
		font = config.font,
		font_size = config.font_size,
	}

	-- Preenchimento da janela
	config.window_padding = {
		left = 2,
		right = 0,
		top = 2,
		bottom = 0,
	}

	-- Cursor
	config.default_cursor_style = "BlinkingBlock" -- 'SteadyBlock', 'BlinkingBlock', 'SteadyUnderline', etc.

	config.cursor_thickness = 2 -- ou um valor em pixels como "2px"

	-- performance
	config.animation_fps = 0
	config.cursor_blink_ease_in = "Constant"
	config.cursor_blink_ease_out = "Constant"

	config.use_resize_increments = true
end
