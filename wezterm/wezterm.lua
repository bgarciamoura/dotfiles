local wezterm = require("wezterm")
local config = {}

-- Enable Wezterm's GPU acceleration
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"

-- Helper function for module loading with error handling
local function load_module(name)
	local success, module = pcall(require, name)
	if success then
		return module
	else
		wezterm.log_error("Failed to load module: " .. name)
		return {}
	end
end

-- Load the modules by name, falling back to empty tables if they don't exist
local appearance = load_module("appearance")
local keys = load_module("keys")
local behavior = load_module("behavior")
local domains = load_module("domains")
local events = load_module("events") -- Will be empty until you create it

-- Apply the configs from the modules
for k, v in pairs(appearance) do
	config[k] = v
end

for k, v in pairs(behavior) do
	config[k] = v
end

-- Handle domains separately to avoid type mismatches
if domains.wsl_domains then
	config.wsl_domains = domains.wsl_domains
end

if domains.ssh_domains then
	config.ssh_domains = domains.ssh_domains
end

-- Any other domain types can be added here

-- Set keys separately to avoid overriding
config.keys = keys

-- OS-specific configurations
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_domain = "WSL:Ubuntu"
elseif wezterm.target_triple:find("darwin") then
	config.default_prog = { "/bin/zsh", "-l" }
else
	config.default_prog = { "/bin/zsh", "-l" }
end

-- Add startup notification
wezterm.on("gui-startup", function()
	local tab, pane, window = wezterm.mux.spawn_window({})
	window:toast_notification("Wezterm Started", "Terminal session ready", nil, 4000)
end)

return config
