local wezterm = require("wezterm")
local act = wezterm.action

return {
	-- Toggle fullscreen
	{ key = "F11", mods = "", action = act.ToggleFullScreen },
	{ key = "Enter", mods = "ALT|SHIFT", action = act.ToggleFullScreen },

	-- Reload configuration
	{ key = "r", mods = "CTRL|SHIFT", action = act.ReloadConfiguration },

	-- Copy and paste
	{ key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
	{ key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },

	-- Font size adjustments
	{ key = "=", mods = "CTRL", action = act.IncreaseFontSize },
	{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
	{ key = "0", mods = "CTRL", action = act.ResetFontSize },

	-- Search functionality
	{ key = "f", mods = "CTRL|SHIFT", action = act.Search("CurrentSelectionOrEmptyString") },

	-- Quick directory navigation
	{ key = "h", mods = "CTRL|SHIFT|ALT", action = act.SendString("cd ~\r") },
	{ key = "p", mods = "CTRL|SHIFT|ALT", action = act.SendString("cd ~/projects\r") },
	{ key = "d", mods = "CTRL|SHIFT|ALT", action = act.SendString("cd ~/Downloads\r") },

	-- Launch programs
	{ key = "e", mods = "CTRL|SHIFT", action = act.SpawnCommandInNewTab({
		args = { "nvim" },
	}) },

	-- Show debug overlay
	{ key = "d", mods = "CTRL|SHIFT", action = act.ShowDebugOverlay },

	-- Activate launcher menu
	{ key = "Space", mods = "CTRL|SHIFT", action = act.ShowLauncher },

	-- Quick select text (like URL)
	{ key = "u", mods = "CTRL|SHIFT", action = act.QuickSelect },

	-- Toggle between panes and tabs
	{ key = "`", mods = "CTRL", action = act.PaneSelect },
	{ key = "s", mods = "CTRL|SHIFT", action = act.PaneSelect({ mode = "SwapWithActive" }) },
}
