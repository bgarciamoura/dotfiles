local wezterm = require 'wezterm'

return {

  -- Abrir uma nova aba
  { key = "n",          mods = "SUPER",       action = wezterm.action { SpawnTab = "CurrentPaneDomain" } },

  -- Fecha a aba atual
  { key = "x",          mods = "CTRL|SHIFT",  action = wezterm.action { CloseCurrentTab = { confirm = true } } },

  -- Troca para a aba da esquerda
  { key = "LeftArrow",  mods = "CTRL|SHIFT",  action = wezterm.action { ActivateTabRelative = -1 } },

  -- Troca para a aba da direita
  { key = "RightArrow", mods = "CTRL|SHIFT",  action = wezterm.action { ActivateTabRelative = 1 } },


  -- Ajustar tamanho dos painéis (expandir/retrair)
  { key = "LeftArrow",  mods = "ALT|SHIFT",   action = wezterm.action { AdjustPaneSize = { "Left", 5 } } },
  { key = "RightArrow", mods = "ALT|SHIFT",   action = wezterm.action { AdjustPaneSize = { "Right", 5 } } },
  { key = "UpArrow",    mods = "ALT|SHIFT",   action = wezterm.action { AdjustPaneSize = { "Up", 5 } } },
  { key = "DownArrow",  mods = "ALT|SHIFT",   action = wezterm.action { AdjustPaneSize = { "Down", 5 } } },

  -- Fechar o painel atual
  { key = "x",          mods = "SUPER",       action = wezterm.action { CloseCurrentPane = { confirm = true } } },


  -- Dividir o painel horizontalmente
  { key = "h",          mods = "CTRL|SUPER",  action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },

  -- Dividir o painel verticalmente
  { key = "v",          mods = "CTRL|SUPER",  action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },

  -- Movimentar entre os painéis
  { key = "h",          mods = "SHIFT|SUPER", action = wezterm.action { ActivatePaneDirection = "Left" } },
  { key = "l",          mods = "SHIFT|SUPER", action = wezterm.action { ActivatePaneDirection = "Right" } },
  { key = "k",          mods = "SHIFT|SUPER", action = wezterm.action { ActivatePaneDirection = "Up" } },
  { key = "j",          mods = "SHIFT|SUPER", action = wezterm.action { ActivatePaneDirection = "Down" } },
}
