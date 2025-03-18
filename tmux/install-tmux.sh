#!/bin/bash

# Cores para melhor legibilidade
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Função para imprimir mensagens coloridas
print_message() {
  local color=$1
  local message=$2
  echo -e "${color}${message}${NC}"
}

# Função para verificar se um comando existe
command_exists() {
  command -v "$1" &>/dev/null
}

# Detectar o sistema operacional
detect_os() {
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if command_exists apt-get; then
      echo "ubuntu"
    elif command_exists dnf; then
      echo "fedora"
    elif command_exists pacman; then
      echo "arch"
    else
      echo "linux"
    fi
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "macos"
  elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
    echo "windows"
  elif [[ -f /proc/version ]] && grep -q Microsoft /proc/version; then
    echo "wsl"
  else
    echo "unknown"
  fi
}

# Função para solicitar confirmação do usuário
confirm() {
  local message=$1
  while true; do
    read -p "$message [S/n] " response
    case $response in
    [Ss]*) return 0 ;; # Retorna sucesso (0) para "Sim"
    [Nn]*) return 1 ;; # Retorna falha (1) para "Não"
    "") return 0 ;;    # Retorna sucesso para Enter (resposta padrão é sim)
    *) echo "Por favor, responda com s ou n." ;;
    esac
  done
}

# Instalar Tmux
install_tmux() {
  local os_type=$(detect_os)

  print_message "$BLUE" "==== Instalando Tmux para $os_type ===="

  case $os_type in
  "ubuntu" | "wsl")
    print_message "$YELLOW" "Instalando Tmux via apt..."
    sudo apt-get update && sudo apt-get install -y tmux
    ;;
  "fedora")
    print_message "$YELLOW" "Instalando Tmux via dnf..."
    sudo dnf install -y tmux
    ;;
  "arch")
    print_message "$YELLOW" "Instalando Tmux via pacman..."
    sudo pacman -S --noconfirm tmux
    ;;
  "macos")
    print_message "$YELLOW" "Instalando Tmux via brew..."
    brew install tmux
    ;;
  *)
    print_message "$RED" "Sistema operacional não suportado para instalação automática."
    print_message "$YELLOW" "Por favor, instale o Tmux manualmente de acordo com sua distribuição."
    exit 1
    ;;
  esac

  if command_exists tmux; then
    local tmux_version=$(tmux -V)
    print_message "$GREEN" "✅ Tmux instalado com sucesso: $tmux_version"
  else
    print_message "$RED" "❌ Falha ao instalar Tmux."
    exit 1
  fi
}

# Configurar Tmux
configure_tmux() {
  print_message "$BLUE" "==== Configurando Tmux ===="

  # Criar backup da configuração existente, se houver
  if [ -f "$HOME/.config/tmux/.tmux.conf" ]; then
    local backup_file="$HOME/.config/tmux/.tmux.conf.backup.$(date +%Y%m%d%H%M%S)"
    print_message "$YELLOW" "Fazendo backup da configuração existente para $backup_file"
    cp "$HOME/.config/tmux/.tmux.conf" "$backup_file"
  fi

  # Copiar nova configuração
  print_message "$YELLOW" "Criando nova configuração do Tmux..."
  cat >"$HOME/.config/tmux/.tmux.conf" <<'EOF'
# ══════════════════════════════════════════════════════════════════════════════
# Tmux Configuration for Development
# Designer para integrar com WezTerm e Neovim
# ══════════════════════════════════════════════════════════════════════════════

# ═══════════════ CONFIGURAÇÕES ESSENCIAIS ═══════════════

# Mudar prefixo de 'Ctrl-b' para 'Ctrl-a' (mais fácil de digitar)
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

# Iniciar indexação de janelas por 1 em vez de 0
set -g base-index 1
set -g pane-base-index 1
set-window-option -g pane-base-index 1
set-option -g renumber-windows on

# Aumentar histórico de rolagem
set -g history-limit 50000

# Reduzir delay ao pressionar Escape (para NeoVim)
set -sg escape-time 10

# Habilitar focus-events para integração melhor com Neovim
set-option -g focus-events on

# Usar modo vi para navegação
set-window-option -g mode-keys vi

# Ativar suporte a terminal true-color
set-option -g default-terminal "tmux-256color"
set -ag terminal-overrides ",xterm-256color:RGB"

# ═══════════════ ERGONOMIA & PRODUTIVIDADE ═══════════════

# Suporte a mouse (rolagem, seleção, etc.)
set -g mouse on

# Recarregar configuração com 'r'
bind r source-file ~/.config/tmux/.tmux.conf \; display "Configuração recarregada!"

# Abrir painéis no mesmo diretório
bind '"' split-window -v -c "#{pane_current_path}"
bind % split-window -h -c "#{pane_current_path}"

# Criar nova janela no diretório atual
bind c new-window -c "#{pane_current_path}"

# Navegação entre painéis no estilo Vim (hjkl)
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# Redimensionar painéis com Alt+teclas direcionais
bind -n M-h resize-pane -L 5
bind -n M-j resize-pane -D 5
bind -n M-k resize-pane -U 5
bind -n M-l resize-pane -R 5

# Alternar entre janelas com Shift+Seta
bind -n S-Left previous-window
bind -n S-Right next-window

# Layout de Desenvolvimento
bind D source-file ~/.config/tmux/.tmux/dev

# ═══════════════ VISUAL & TEMA ═══════════════

# Tema Cyberpunk para Tmux
# Cores inspiradas no tema cyberpunk do Neovim

# Definir cores primárias
NEON_PINK="#ff00ff"
NEON_CYAN="#00ffff"
NEON_GREEN="#00ff00"
DARK_BG="#0a0b11"
SOFT_FG="#c8c8c8"

# Barra de status
set -g status-position bottom
set -g status-style "bg=$DARK_BG,fg=$SOFT_FG"
set -g status-left "#[fg=$DARK_BG,bg=$NEON_CYAN,bold] #S #[fg=$NEON_CYAN,bg=$DARK_BG]"
set -g status-right "#{?client_prefix,#[fg=$NEON_PINK]#[bg=$DARK_BG]  #[default],} #[fg=$NEON_GREEN,bg=$DARK_BG] %d/%m #[fg=$DARK_BG,bg=$NEON_GREEN,bold] %H:%M "
set -g status-left-length 50
set -g status-right-length 50

# Formatação de janelas
setw -g window-status-format "#[fg=$SOFT_FG,bg=$DARK_BG] #I:#W "
setw -g window-status-current-format "#[fg=$DARK_BG,bg=$NEON_PINK,bold] #I:#W #[fg=$NEON_PINK,bg=$DARK_BG]"
setw -g window-status-separator ""

# Borda de painel
set -g pane-border-style "fg=#333333"
set -g pane-active-border-style "fg=$NEON_PINK"

# Mensagens
set -g message-style "bg=$NEON_CYAN,fg=$DARK_BG,bold"

# ═══════════════ PLUGINS ═══════════════
# Instalar com: git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/.tmux/plugins/tpm

# Plugin Manager
set -g @plugin 'tmux-plugins/tpm'

# Persistência de sessão (restaura sessões após reinicialização)
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'
set -g @continuum-restore 'on'
set -g @resurrect-capture-pane-contents 'on'
set -g @resurrect-strategy-nvim 'session' # Para Neovim

# Navegação entre painéis do tmux e janelas do vim
set -g @plugin 'christoomey/vim-tmux-navigator'

# Gerenciamento de sessões
set -g @plugin 'tmux-plugins/tmux-sessionist'

# Inicializar TMUX plugin manager (deve ficar no final)
run '~/.config/tmux/.tmux/plugins/tpm/tpm'
EOF

  # Criar diretório para layouts customizados
  mkdir -p "$HOME/.config/tmux/.tmux"

  # Criar layout de desenvolvimento
  cat >"$HOME/.config/tmux/.tmux/dev" <<'EOF'
# Layout de desenvolvimento padrão
# Editor à esquerda (70%), terminais à direita (30%)
# Dois terminais na coluna direita

# Criar um layout de desenvolvimento com editor e terminais
selectp -t 1              # Selecionar o painel 1
splitw -h -p 30           # Dividir horizontalmente com 30% à direita
selectp -t 2              # Selecionar o painel 2 (terminal)
splitw -v -p 50           # Dividir verticalmente com 50%
selectp -t 1              # Voltar para o editor (painel 1)

# Opcional: iniciar aplicativos automáticos neste layout
# Descomente as linhas abaixo conforme necessário

# Iniciar editor no painel principal
send-keys -t 1 'nvim' C-m

# Navegação básica no terminal 1
send-keys -t 2 'ls -la' C-m

# Monitoramento no terminal 2
send-keys -t 3 'htop' C-m
EOF

  print_message "$GREEN" "✅ Configuração do Tmux criada com sucesso"
}

# Instalar Tmux Plugin Manager (TPM)
install_tpm() {
  print_message "$BLUE" "==== Instalando Tmux Plugin Manager (TPM) ===="

  local tpm_dir="$HOME/.config/tmux/.tmux/plugins/tpm"

  if [ -d "$tpm_dir" ]; then
    print_message "$YELLOW" "TPM já está instalado em $tpm_dir"

    if confirm "Deseja atualizar o TPM?"; then
      print_message "$YELLOW" "Atualizando TPM..."
      cd "$tpm_dir" && git pull
      print_message "$GREEN" "✅ TPM atualizado com sucesso"
    fi
  else
    print_message "$YELLOW" "Instalando TPM..."
    git clone https://github.com/tmux-plugins/tpm "$tpm_dir"

    if [ $? -eq 0 ]; then
      print_message "$GREEN" "✅ TPM instalado com sucesso"
    else
      print_message "$RED" "❌ Falha ao instalar TPM. Verifique sua conexão com a internet e o acesso ao GitHub."
      return 1
    fi
  fi

  # Instalar plugins automaticamente
  print_message "$YELLOW" "Instalando plugins do Tmux..."
  "$HOME/.config/tmux/.tmux/plugins/tpm/scripts/install_plugins.sh"

  print_message "$GREEN" "✅ Plugins do Tmux instalados com sucesso"
}

# Integrar com Neovim
setup_neovim_integration() {
  print_message "$BLUE" "==== Configurando integração com Neovim ===="

  local nvim_config_dir="$HOME/.config/nvim"

  if [ ! -d "$nvim_config_dir" ]; then
    print_message "$YELLOW" "Diretório de configuração do Neovim não encontrado: $nvim_config_dir"
    print_message "$YELLOW" "Pulando configuração de integração com Neovim."
    return 0
  fi

  # Verificar se já existe arquivo de integração
  local integration_file="$nvim_config_dir/lua/plugins/tmux.lua"

  # Criar diretório se não existir
  mkdir -p "$nvim_config_dir/lua/plugins"

  print_message "$YELLOW" "Criando plugin de integração Tmux-Neovim..."

  cat >"$integration_file" <<'EOF'
return {
  -- Navegação entre painéis do Tmux e janelas do Neovim
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    config = function()
      -- Configuração de navegação entre painéis no estilo Vim
      vim.g.tmux_navigator_no_mappings = 1
      
      -- Mapeamentos personalizados para navegação entre painéis
      vim.keymap.set('n', '<C-h>', ':<C-U>TmuxNavigateLeft<CR>', { silent = true })
      vim.keymap.set('n', '<C-j>', ':<C-U>TmuxNavigateDown<CR>', { silent = true })
      vim.keymap.set('n', '<C-k>', ':<C-U>TmuxNavigateUp<CR>', { silent = true })
      vim.keymap.set('n', '<C-l>', ':<C-U>TmuxNavigateRight<CR>', { silent = true })
      
      -- Suporte para ressurreição de sessão
      vim.g.tmux_navigator_save_on_switch = 2
    end,
  },
  
  -- Integração de status line com o Tmux
  {
    "vimpostor/vim-tpipeline",
    lazy = false,
    config = function()
      vim.g.tpipeline_autoembed = 1
      vim.g.tpipeline_statusline = '%!v:lua.require("lualine").statusline()'
    end,
  },
}
EOF

  print_message "$GREEN" "✅ Integração com Neovim configurada com sucesso"
  print_message "$YELLOW" "Nota: Você precisa reiniciar o Neovim para aplicar as alterações"
}

# Função principal
main() {
  print_message "$MAGENTA" "===== Script de Instalação e Configuração do Tmux ====="
  print_message "$CYAN" "Este script instalará e configurará o Tmux para integrar com WezTerm e Neovim."

  # Verificar se Tmux já está instalado
  if command_exists tmux; then
    local tmux_version=$(tmux -V)
    print_message "$GREEN" "Tmux já está instalado: $tmux_version"

    if ! confirm "Deseja prosseguir com a configuração do Tmux?"; then
      print_message "$YELLOW" "Instalação cancelada pelo usuário."
      exit 0
    fi
  else
    print_message "$YELLOW" "Tmux não encontrado. Instalando..."
    install_tmux
  fi

  # Configurar Tmux
  configure_tmux

  # Instalar TPM
  install_tpm

  # Configurar integração com Neovim
  if confirm "Deseja configurar a integração com Neovim?"; then
    setup_neovim_integration
  else
    print_message "$YELLOW" "Configuração de integração com Neovim ignorada pelo usuário."
  fi

  print_message "$MAGENTA" "===== Instalação e Configuração do Tmux Concluída ====="
  print_message "$GREEN" "Para iniciar uma nova sessão do Tmux, execute:"
  print_message "$CYAN" "  tmux"
  print_message "$GREEN" "Para listar atalhos configurados, pressione:"
  print_message "$CYAN" "  Ctrl-a ?"
  print_message "$GREEN" "Para instalar plugins, pressione:"
  print_message "$CYAN" "  Ctrl-a I"
  print_message "$GREEN" "Para ativar o layout de desenvolvimento, pressione:"
  print_message "$CYAN" "  Ctrl-a D"
}

# Verificar se o script está sendo executado como fonte ou diretamente
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  # Executar a função principal
  main
fi
