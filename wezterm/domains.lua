local wezterm = require("wezterm")

-- Detect OS and platform
local is_windows = wezterm.target_triple:find("windows") ~= nil
local is_mac = wezterm.target_triple:find("darwin") ~= nil
local is_linux = not is_windows and not is_mac

-- Configuration for different domains (environments)
local domains = {}

-- WSL domain setup for Windows
if is_windows then
	table.insert(domains, {
		name = "WSL:Ubuntu",
		distribution = "Ubuntu",
		default_cwd = "~",
		default_prog = { "zsh", "-l" },
	})

	-- Add PowerShell
	table.insert(domains, {
		name = "PowerShell",
		default_prog = { "powershell.exe", "-NoLogo" },
		default_cwd = "C:\\Users\\$USER\\Documents",
	})
end

-- SSH domains for quick connections
table.insert(domains, {
	name = "SSH:MyServer",
	remote_address = "myserver.example.com",
	username = "myuser",
	ssh_option = {
		identityfile = "~/.ssh/id_rsa",
	},
})

-- macOS specific domains
if is_mac then
	table.insert(domains, {
		name = "Dev Environment",
		default_cwd = "~/Development",
		default_prog = { "zsh", "-l" },
	})
end

-- Linux specific domains
if is_linux then
	table.insert(domains, {
		name = "Docker Helper",
		default_cwd = "~/docker",
		default_prog = { "zsh", "-l" },
	})
end

return {
	wsl_domains = domains,
	ssh_domains = domains,
}
