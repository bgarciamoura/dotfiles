local wezterm = require("wezterm")
local act = wezterm.action

return {
	-- Tab navigation
	{ key = "t", mods = "CTRL", action = act.SpawnTab("DefaultDomain") },
	{ key = "w", mods = "CTRL", action = act.CloseCurrentTab({ confirm = true }) },
	{ key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
	{ key = "Tab", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },
	{ key = "1", mods = "CTRL", action = act.ActivateTab(0) },
	{ key = "2", mods = "CTRL", action = act.ActivateTab(1) },
	{ key = "3", mods = "CTRL", action = act.ActivateTab(2) },
	{ key = "4", mods = "CTRL", action = act.ActivateTab(3) },
	{ key = "5", mods = "CTRL", action = act.ActivateTab(4) },

	-- Pane splitting
	{ key = "\\", mods = "CTRL|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "-", mods = "CTRL|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

	-- Pane navigation
	{ key = "h", mods = "ALT", action = act.ActivatePaneDirection("Left") },
	{ key = "l", mods = "ALT", action = act.ActivatePaneDirection("Right") },
	{ key = "k", mods = "ALT", action = act.ActivatePaneDirection("Up") },
	{ key = "j", mods = "ALT", action = act.ActivatePaneDirection("Down") },

	-- Close current pane
	{ key = "x", mods = "CTRL|SHIFT", action = act.CloseCurrentPane({ confirm = true }) },

	-- Adjust pane size
	{ key = "LeftArrow", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) },
	{ key = "RightArrow", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },
	{ key = "UpArrow", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Up", 3 }) },
	{ key = "DownArrow", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Down", 3 }) },

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
