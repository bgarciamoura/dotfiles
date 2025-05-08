return function(config, wezterm)
  -- Onde o terminal deve se identificar (útil para ssh, etc.)
  config.term = 'xterm-256color'   -- ou 'xterm-256color'

  -- Desabilitar o sino audível
  config.audible_bell = 'Disabled'

  -- Recarregar automaticamente a configuração quando o arquivo for salvo
  config.automatically_reload_config = true

  -- Número de linhas de scrollback
  config.scrollback_lines = 5000

  -- Remover a confirmação de fechar a janela
  config.window_close_confirmation = 'NeverPrompt'
  config.skip_close_confirmation_for_processes_named = {
    'bash', 'sh', 'zsh', 'fish', 'tmux',
  }
end

