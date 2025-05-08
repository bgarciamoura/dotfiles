local wezterm = require("wezterm")
local act = wezterm.action

-- Tema Kanagawa Dragon (cores oficiais)
local kanagawa_dragon = {
	-- Texto e fundo
	foreground = "#c5c9c5",
	background = "#181616",

	-- Cursor
	cursor_bg = "#C8C093",
	cursor_fg = "#C8C093",
	cursor_border = "#C8C093",

	-- Seleção
	selection_fg = "#C8C093",
	selection_bg = "#2D4F67",

	-- Barra de rolagem e divisores
	scrollbar_thumb = "#16161D",
	split = "#16161D",

	-- ANSI padrão
	ansi = {
		"#0D0C0C", -- Black
		"#C4746E", -- Red
		"#8A9A7B", -- Green
		"#C4B28A", -- Yellow
		"#8BA4B0", -- Blue
		"#A292A3", -- Magenta
		"#8EA4A2", -- Cyan
		"#C8C093", -- White
	},

	-- ANSI brilhante
	brights = {
		"#A6A69C", -- Bright Black
		"#E46876", -- Bright Red
		"#87A987", -- Bright Green
		"#E6C384", -- Bright Yellow
		"#7FB4CA", -- Bright Blue
		"#938AA9", -- Bright Magenta
		"#7AA89F", -- Bright Cyan
		"#C5C9C5", -- Bright White
	},
}

-- Configuração do frame da janela
local window_frame = {
	font = wezterm.font({ family = "RobotoMono Nerd Font", weight = "Bold" }),
	font_size = 10.0,
	active_titlebar_bg = "#181616",
	inactive_titlebar_bg = "#181616",
}

return {
	-- Inverte vídeo do cursor para mantê-lo visível
	force_reverse_video_cursor = true,

	-- Tamanho inicial
	initial_rows = 50,
	initial_cols = 140,

	-- Fonte principal
	font = wezterm.font_with_fallback({
		{ family = "Iosevka Nerd Font", weight = "Regular", scale = 1.1 },
		{ family = "RobotoMono Nerd Font", weight = "Regular" },
		{ family = "JetBrainsMono Nerd Font", weight = "Regular" },
		{ family = "Symbols Nerd Font Mono", scale = 0.9 },
	}),
	font_size = 10,
	line_height = 1.1,

	-- Padding e opacidade
	window_padding = { left = 0, right = 0, top = 0, bottom = 5 },
	window_background_opacity = 0.95,
	text_background_opacity = 1.0,
	window_decorations = "TITLE | RESIZE",
	window_frame = window_frame,

	-- Aplica o tema Kanagawa Dragon
	colors = kanagawa_dragon,

	-- Barra de abas
	enable_tab_bar = true,
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = false,
	tab_max_width = 25,
	show_tab_index_in_tab_bar = true,

	-- Background customizado
	background = {
		{
			source = { File = wezterm.config_dir .. "/background.jpg" },
			width = "100%",
			height = "100%",
			opacity = 0.07,
		},
	},

	-- Cursor piscante em bloco
	default_cursor_style = "BlinkingBlock",
	cursor_thickness = 2,
}
