return function(config, wezterm)
    config.default_prog = { 'wsl.exe', '~' }
    -- Se você tem apenas uma distro WSL ou quer a padrão:
    -- config.default_prog = { 'wsl.exe', '~' }
  
    -- Domínios WSL para o lançador (Ctrl+Shift+L por padrão)
    -- WezTerm geralmente detecta automaticamente, mas você pode especificar.
    config.wsl_domains = wezterm.default_wsl_domains()
  
    -- Menu de lançamento personalizado (opcional)
    -- Adicione entradas ao menu que aparece com Ctrl+Shift+L (padrão) ou `wezterm cli launch-menu`
    -- config.launch_menu = {
    --   {
    --     label = "PowerShell",
    --     args = {"powershell.exe", "-NoLogo"},
    --   },
    --   {
    --     label = "Bash (WSL)",
    --     args = {"wsl.exe", "~"},
    --   },
    --   -- Adicione mais entradas aqui
    -- }
  end