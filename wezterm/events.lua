local wezterm = require("wezterm")

-- Event handler for updating window title dynamically
wezterm.on("update-status", function(window, pane)
	-- Get process and directory
	local process = pane:get_foreground_process_name() or ""
	process = process:gsub(".*[/\\]", "")

	local cwd = pane:get_current_working_dir() or ""
	if cwd then
		cwd = cwd.file_path or cwd.path or ""
		cwd = cwd:gsub("^" .. wezterm.home_dir, "~")
	end

	-- Format title
	local title = ""

	if process ~= "" then
		title = process .. " • "
	end

	title = title .. cwd

	-- Update title
	window:set_title(title)
end)

-- Custom tab title formatting
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local tab_index = tab.tab_index + 1
	local pane = tab.active_pane

	local title = pane.title

	-- Try getting process name if title appears to be default
	if title == "zsh" or title == "bash" or title == "sh" or title == "fish" then
		local process = pane:get_foreground_process_name()
		if process then
			process = process:gsub(".*[/\\]", "")
			if process ~= "zsh" and process ~= "bash" and process ~= "sh" and process ~= "fish" then
				title = process
			else
				-- Try using path instead
				local cwd = pane:get_current_working_dir()
				if cwd then
					local path = cwd.file_path or ""
					title = path:match("[^/\\]+$") or title
				end
			end
		end
	end

	-- Truncate title if needed
	if #title > 15 then
		title = wezterm.truncate_right(title, 15) .. "…"
	end

	-- Different formatting for active tab
	if tab.is_active then
		return {
			{ Foreground = { Color = "#1a1b26" } },
			{ Background = { Color = "#7aa2f7" } },
			{ Text = " " .. tab_index .. ": " .. title .. " " },
		}
	else
		return {
			{ Foreground = { Color = "#a9b1d6" } },
			{ Background = { Color = "#292e42" } },
			{ Text = " " .. tab_index .. ": " .. title .. " " },
		}
	end
end)

-- Event when window is resized
wezterm.on("window-resized", function(window, pane)
	-- You can add custom handlers here when window size changes
end)
