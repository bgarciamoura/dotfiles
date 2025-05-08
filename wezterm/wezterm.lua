local wezterm = require 'wezterm'

local config = wezterm.config_builder()

require('core.settings')(config, wezterm)
require('core.appearance')(config, wezterm)
require('core.mouse')(config, wezterm)
require('core.launch')(config, wezterm)
require('core.keys')(config, wezterm)

return config