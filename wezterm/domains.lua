local wezterm = require("wezterm")

-- Detect OS and platform
local is_windows = wezterm.target_triple:find("windows") ~= nil
local is_mac = wezterm.target_triple:find("darwin") ~= nil
local is_linux = not is_windows and not is_mac

-- Configuration for different domains (environments)
local wsl_domains = {}
local ssh_domains = {}

-- WSL domain setup for Windows
if is_windows then
	table.insert(wsl_domains, {
		name = "WSL:Ubuntu",
		distribution = "Ubuntu",
		default_cwd = "~",
		default_prog = { "zsh", "-l" },
	})

	-- Add PowerShell
	table.insert(wsl_domains, {
		name = "PowerShell",
		default_prog = { "powershell.exe", "-NoLogo" },
		default_cwd = "C:\\Users\\$USER\\Documents",
	})
end

-- SSH domains for quick connections
-- Only add if you have actual servers to connect to
-- table.insert(ssh_domains, {
--   name = "MyServer",
--   remote_address = "myserver.example.com",
--   username = "myuser",
--   ssh_option = {
--     identityfile = "~/.ssh/id_rsa"
--   }
-- })

-- macOS specific domains (not SSH or WSL, just local domains)
local default_domains = {}
if is_mac then
	table.insert(default_domains, {
		name = "Dev Environment",
		default_cwd = "~/Development",
		default_prog = { "zsh", "-l" },
	})
end

-- Linux specific domains (not SSH or WSL, just local domains)
if is_linux then
	table.insert(default_domains, {
		name = "Docker Helper",
		default_cwd = "~/docker",
		default_prog = { "zsh", "-l" },
	})
end

return {
	wsl_domains = wsl_domains,
	ssh_domains = ssh_domains,
	-- You can add other domain types here if needed
	default_domains = default_domains,
}
