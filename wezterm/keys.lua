local wezterm = require("wezterm")

return {
  -- Navegação entre abas
  { key = "t",     mods = "CTRL",       action = wezterm.action.SpawnTab("DefaultDomain") },           -- Nova aba
  { key = "w",     mods = "CTRL",       action = wezterm.action.CloseCurrentTab({ confirm = true }) }, -- Fechar aba atual
  { key = "Tab",   mods = "CTRL",       action = wezterm.action.ActivateTabRelative(1) },              -- Próxima aba
  { key = "Tab",   mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },             -- Aba anterior

  -- Divisão de painéis
  { key = "H",     mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) }, -- Split horizontal
  { key = "V",     mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },   -- Split vertical

  -- Movimentação entre painéis
  { key = "h",     mods = "ALT",        action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "l",     mods = "ALT",        action = wezterm.action.ActivatePaneDirection("Right") },
  { key = "k",     mods = "ALT",        action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "j",     mods = "ALT",        action = wezterm.action.ActivatePaneDirection("Down") },

  -- Fechar o painel atual
  { key = "x",     mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentPane({ confirm = true }) },

  -- Ajuste do tamanho dos painéis
  { key = "H",     mods = "CTRL|ALT",   action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
  { key = "L",     mods = "CTRL|ALT",   action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },
  { key = "K",     mods = "CTRL|ALT",   action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
  { key = "J",     mods = "CTRL|ALT",   action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },

  -- Alternar para tela cheia
  { key = "Enter", mods = "ALT|SHIFT",  action = wezterm.action.ToggleFullScreen },

  -- Recarregar configuração
  { key = "r",     mods = "CTRL|SHIFT", action = wezterm.action.ReloadConfiguration },

  -- Copy Paste
  { key = "c",     mods = "CTRL",       action = wezterm.action({ CopyTo = "Clipboard" }) },
  { key = "v",     mods = "CTRL",       action = wezterm.action({ PasteFrom = "Clipboard" }) },
}
