local wezterm = require("wezterm")
local io = require("io")
local os = require("os")

-- Get home directory in a cross-platform way
local home = os.getenv("HOME") or os.getenv("USERPROFILE")

-- Determine default starting directory
local default_cwd = home
if wezterm.target_triple:find("windows") then
	default_cwd = home
elseif wezterm.target_triple:find("darwin") then
	default_cwd = home
else
	default_cwd = home
end

-- Handle URL clicks
local function extract_url_and_open(window, pane)
	local url = window:get_selection_text_for_pane(pane)
	if url then
		wezterm.log_info("Opening URL: " .. url)
		wezterm.open_with(url)
	end
end

return {
	-- General settings
	automatically_reload_config = true,
	check_for_updates = true,
	check_for_updates_interval_seconds = 86400, -- Check once per day
	animation_fps = 60,
	enable_scroll_bar = true,

	-- Melhorar integração com Tmux
	allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace",
	custom_block_glyphs = true,
	warn_about_missing_glyphs = false,

	-- Acertar a sinalização de teclas no terminal para melhor compatibilidade com Tmux e Neovim
	enable_kitty_keyboard = true,
	enable_csi_u_key_encoding = true,

	-- Performance settings
	front_end = "WebGpu", -- Can be "WebGpu" or "Software"
	webgpu_power_preference = "HighPerformance",
	enable_wayland = false,

	-- Scrollback and history
	scrollback_lines = 10000,
	enable_kitty_keyboard = true,

	-- Cursor settings
	cursor_blink_rate = 500,
	cursor_blink_ease_in = "Linear",
	cursor_blink_ease_out = "Linear",

	-- Default locations
	default_cwd = default_cwd,

	-- Selection behavior
	selection_word_boundary = " \t\n{}[]()\"'`,;:",

	-- Mouse settings
	mouse_bindings = {
		-- Right click sends a "paste" action
		{
			event = { Down = { streak = 1, button = "Right" } },
			mods = "NONE",
			action = wezterm.action.PasteFrom("Clipboard"),
		},
		-- Triple-click to select a line
		{
			event = { Down = { streak = 3, button = "Left" } },
			action = wezterm.action.SelectTextAtMouseCursor("Line"),
			mods = "NONE",
		},
		-- Ctrl+click to open URLs
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action_callback(extract_url_and_open),
		},
	},

	-- URL handling
	hyperlink_rules = {
		-- Standard URLs (simplified version with safer regex)
		{
			regex = "\\b\\w+://[\\w.-]+(?::\\d+)?(?:/[\\w.~:/?#@!$&'()*+,;=-]*)?",
			format = "$0",
		},
		-- File paths
		{
			regex = "\\b(?:(?:[a-zA-Z]:|\\\\\\\\)[^\\s\\\\]+|~[^\\s]+|/[^\\s\\\\]+)\\b",
			format = "$0",
		},
		-- GitHub repo references
		{
			regex = "\\b(?:https?://)?(?:www\\.)?github\\.com/([a-zA-Z0-9\\-]+)/([a-zA-Z0-9\\-\\.]+)\\b",
			format = "https://github.com/$1/$2",
		},
	},

	-- Terminal window handling
	adjust_window_size_when_changing_font_size = true,
	window_close_confirmation = "AlwaysPrompt",

	-- Notifications
	audible_bell = "Disabled",
	visual_bell = {
		fade_in_duration_ms = 75,
		fade_out_duration_ms = 75,
		target = "CursorColor",
	},

	-- Launching processes
	launch_menu = {
		{
			label = "Bash",
			args = { "bash", "-l" },
		},
		{
			label = "Fish",
			args = { "fish", "-l" },
		},
		{
			label = "Zsh",
			args = { "zsh", "-l" },
		},
		{
			label = "NeoVim",
			args = { "nvim" },
		},
		{
			label = "Htop",
			args = { "htop" },
		},
	},

	-- Window close behavior
	exit_behavior = "Close",
	clean_exit_codes = { 0, 130 },
}
