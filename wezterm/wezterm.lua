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

-- Script para verificar/criar o .zshenv
local setup_zshenv_script = [[
  if [ ! -f $HOME/.zshenv ]; then
    echo 'export ZDOTDIR="$HOME/.config/zsh"' > $HOME/.zshenv
    mkdir -p $HOME/.config/zsh
    # Verificar se .zshrc existe e copiá-lo para o novo local se necessário
    if [ -f $HOME/.zshrc ] && [ ! -f $HOME/.config/zsh/.zshrc ]; then
      cp $HOME/.zshrc $HOME/.config/zsh/.zshrc
    fi
  fi
  exec /bin/zsh -l
]]

-- OS-specific configurations
if wezterm.target_triple:find("windows") then
  -- Obter todos os domínios WSL disponíveis
  local wsl_domains = wezterm.default_wsl_domains()
  
  if wsl_domains and #wsl_domains > 0 then
    -- Para cada domínio WSL, configurar para usar zsh com o script de configuração
    for _, domain in ipairs(wsl_domains) do
      wezterm.log_info("Found WSL distribution: " .. domain.name)
      -- Usar bash para executar o script de configuração e depois iniciar zsh
      domain.default_prog = { "/bin/bash", "-c", setup_zshenv_script }
    end
    
    -- Configurar explicitamente os domínios WSL disponíveis
    config.wsl_domains = wsl_domains
    
    -- Encontrar a distribuição Ubuntu, se existir
    local ubuntu_domain = nil
    for _, domain in ipairs(wsl_domains) do
      if domain.name:find("Ubuntu") then
        ubuntu_domain = domain.name
        break
      end
    end
    
    -- Definir o domínio padrão
    if ubuntu_domain then
      wezterm.log_info("Setting default domain to: " .. ubuntu_domain)
      config.default_domain = ubuntu_domain
    else
      -- Se não encontrar Ubuntu, usar o primeiro domínio disponível
      wezterm.log_info("No Ubuntu found, using first WSL domain: " .. wsl_domains[1].name)
      config.default_domain = wsl_domains[1].name
    end
  else
    -- Se não houver domínios WSL, usar PowerShell
    wezterm.log_info("No WSL domains found, using PowerShell")
    config.default_prog = {"powershell.exe", "-NoLogo"}
  end
elseif wezterm.target_triple:find("darwin") then
  -- Usar o script de configuração no macOS
  config.default_prog = { "/bin/bash", "-c", setup_zshenv_script }
else
  -- Usar o script de configuração no Linux
  config.default_prog = { "/bin/bash", "-c", setup_zshenv_script }
end

-- Add startup notification
--wezterm.on("gui-startup", function()
--	local tab, pane, window = wezterm.mux.spawn_window({})
	--window:toast_notification("Wezterm Started", "Terminal session ready", nil, 4000)
--end)

return config
