local wezterm = require 'wezterm'

-- Função de carregamento de módulos
local function load_module(name)
  return require(name)
end

-- Carregue seus módulos de configuração aqui
local config = {}

-- Carregar configurações de aparência
local appearance = load_module('appearance')
for k, v in pairs(appearance) do
  config[k] = v
end

-- Carregar configurações de atalhos
local keys = load_module('keys')
config.keys = keys

-- Carregar outras configurações de comportamento
local behavior = load_module('behavior')
for k, v in pairs(behavior) do
  config[k] = v
end

return config
