return function(config, wezterm)
    -- Desabilitar atalhos padrão que você não quer, se necessário
    -- config.disable_default_key_bindings = true -- CUIDADO: desabilita TUDO
  
    config.keys = {
      -- Copiar e Colar
      { key = 'c', mods = 'CTRL|SHIFT', action = wezterm.action.CopyTo 'Clipboard' },
      { key = 'v', mods = 'CTRL|SHIFT', action = wezterm.action.PasteFrom 'Clipboard' },
  
      -- Navegação entre abas
      { key = 'Tab', mods = 'CTRL',       action = wezterm.action.ActivateTabRelative(1) },
      { key = 'Tab', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateTabRelative(-1) },
      -- Atalhos numéricos para abas (ex: Ctrl+1 para aba 1)
      -- { key = '1', mods = 'CTRL', action = wezterm.action.ActivateTab(0) }, -- Aba 1
      -- { key = '2', mods = 'CTRL', action = wezterm.action.ActivateTab(1) }, -- Aba 2
      -- ... e assim por diante até 9
  
      -- Criar nova aba
      { key = 't', mods = 'CTRL|SHIFT', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
  
      -- Fechar aba/painel atual
      { key = 'w', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentPane { confirm = false } },
      { key = 'q', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentTab { confirm = false } },
  
  
      -- Zoom (aumentar/diminuir fonte)
      { key = '=', mods = 'CTRL',       action = wezterm.action.IncreaseFontSize },
      { key = '+', mods = 'CTRL',       action = wezterm.action.IncreaseFontSize },
      { key = '-', mods = 'CTRL',       action = wezterm.action.DecreaseFontSize },
      { key = '_', mods = 'CTRL',       action = wezterm.action.DecreaseFontSize },
      { key = '0', mods = 'CTRL',       action = wezterm.action.ResetFontSize },
  
  
      -- Dividir painéis
      -- Usar % para horizontal (como no vim) e " para vertical (como no vim)
      { key = '|', mods = 'ALT|SHIFT',  action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
      { key = '_', mods = 'ALT|SHIFT',  action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  
      -- Navegar entre painéis
      { key = 'h', mods = 'ALT',        action = wezterm.action.ActivatePaneDirection 'Left' },
      { key = 'j', mods = 'ALT',        action = wezterm.action.ActivatePaneDirection 'Down' },
      { key = 'k', mods = 'ALT',        action = wezterm.action.ActivatePaneDirection 'Up' },
      { key = 'l', mods = 'ALT',        action = wezterm.action.ActivatePaneDirection 'Right' },
      -- Para usar setas:
      -- { key = 'LeftArrow',  mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Left' },
      -- { key = 'RightArrow', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Right' },
      -- { key = 'UpArrow',    mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Up' },
      -- { key = 'DownArrow',  mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Down' },
  
      -- Redimensionar painéis
      { key = 'H', mods = 'ALT|SHIFT',  action = wezterm.action.AdjustPaneSize { 'Left', 1 } },
      { key = 'J', mods = 'ALT|SHIFT',  action = wezterm.action.AdjustPaneSize { 'Down', 1 } },
      { key = 'K', mods = 'ALT|SHIFT',  action = wezterm.action.AdjustPaneSize { 'Up', 1 } },
      { key = 'L', mods = 'ALT|SHIFT',  action = wezterm.action.AdjustPaneSize { 'Right', 1 } },
  
      -- Alternar para modo de cópia (similar ao tmux)
      { key = '[', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateCopyMode },
  
      -- Pesquisa
      { key = 'f', mods = 'CTRL|SHIFT', action = wezterm.action.Search { CaseSensitiveString = "" } },
  
      -- Adicione mais mapeamentos de teclas aqui
    }
  
    -- Você também pode usar um "leader key"
    -- config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
    -- config.keys = {
    --   { key = 'c', mods = 'LEADER', action = wezterm.action.CopyTo 'Clipboard' },
    --   -- ... outros atalhos com leader
    -- }
  end