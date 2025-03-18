#!/bin/bash

# Script de instalação completa do Tmuxinator com templates

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

# Função para verificar dependências
check_dependencies() {
  print_message "$BLUE" "Verificando dependências..."

  # Verificar se Tmux está instalado
  if ! command -v tmux &>/dev/null; then
    print_message "$RED" "Tmux não encontrado!"

    if command -v apt-get &>/dev/null; then
      print_message "$YELLOW" "Instalando Tmux via apt..."
      sudo apt-get update && sudo apt-get install -y tmux
    elif command -v brew &>/dev/null; then
      print_message "$YELLOW" "Instalando Tmux via Homebrew..."
      brew install tmux
    else
      print_message "$RED" "Não foi possível instalar o Tmux automaticamente."
      print_message "$YELLOW" "Por favor, instale o Tmux manualmente e execute este script novamente."
      exit 1
    fi
  fi

  # Verificar Ruby
  if ! command -v ruby &>/dev/null; then
    print_message "$RED" "Ruby não encontrado!"

    if command -v apt-get &>/dev/null; then
      print_message "$YELLOW" "Instalando Ruby via apt..."
      sudo apt-get update && sudo apt-get install -y ruby ruby-dev
    elif command -v brew &>/dev/null; then
      print_message "$YELLOW" "Instalando Ruby via Homebrew..."
      brew install ruby
    else
      print_message "$RED" "Não foi possível instalar o Ruby automaticamente."
      print_message "$YELLOW" "Por favor, instale o Ruby manualmente e execute este script novamente."
      exit 1
    fi
  fi

  # Verificar outros utilitários
  local missing_utils=()
  for util in git mkdir chmod cat; do
    if ! command -v $util &>/dev/null; then
      missing_utils+=($util)
    fi
  done

  if [ ${#missing_utils[@]} -gt 0 ]; then
    print_message "$RED" "Utilitários necessários não encontrados: ${missing_utils[*]}"
    print_message "$YELLOW" "Por favor, instale os utilitários necessários e execute este script novamente."
    exit 1
  fi

  print_message "$GREEN" "✅ Todas as dependências estão satisfeitas"
}

# Instalar Tmuxinator
install_tmuxinator() {
  print_message "$BLUE" "Instalando Tmuxinator..."

  if command -v tmuxinator &>/dev/null; then
    print_message "$GREEN" "✅ Tmuxinator já está instalado: $(tmuxinator version)"
    return 0
  fi

  # Se o usuário tiver rbenv, use isso
  if command -v rbenv &>/dev/null; then
    print_message "$BLUE" "Usando rbenv para instalar..."
    gem install tmuxinator
    rbenv rehash
  # Se o usuário tiver rvm, use isso
  elif command -v rvm &>/dev/null; then
    print_message "$BLUE" "Usando rvm para instalar..."
    gem install tmuxinator
  # Caso contrário, instale normalmente
  else
    print_message "$BLUE" "Instalando via gem..."
    gem install tmuxinator
  fi

  if ! command -v tmuxinator &>/dev/null; then
    print_message "$YELLOW" "Tentando instalação via gem com sudo..."
    sudo gem install tmuxinator
  fi

  if command -v tmuxinator &>/dev/null; then
    print_message "$GREEN" "✅ Tmuxinator instalado com sucesso: $(tmuxinator version)"
  else
    print_message "$RED" "❌ Falha ao instalar Tmuxinator."
    exit 1
  fi
}

# Configurar shell para Tmuxinator
setup_shell_integration() {
  print_message "$BLUE" "Configurando shell para Tmuxinator..."

  # Detectar shell
  local shell_rc=""
  if [[ "$SHELL" == *"zsh"* ]]; then
    shell_rc="$HOME/.config/zsh/.zshrc"
  elif [[ "$SHELL" == *"bash"* ]]; then
    shell_rc="$HOME/.bashrc"
  else
    print_message "$YELLOW" "Shell não reconhecido: $SHELL"
    print_message "$YELLOW" "Adicionando configurações ao .bashrc como padrão."
    shell_rc="$HOME/.bashrc"
  fi

  # Adicionar alias se não existir
  if ! grep -q "alias mux=" "$shell_rc"; then
    echo -e "\n# Tmuxinator aliases" >>"$shell_rc"
    echo "alias mux='tmuxinator'" >>"$shell_rc"
    echo "alias txs='tmuxinator start'" >>"$shell_rc"
    echo "alias txn='tmuxinator new'" >>"$shell_rc"
    echo "alias txl='tmuxinator list'" >>"$shell_rc"
    print_message "$GREEN" "✅ Aliases adicionados ao $shell_rc"
  else
    print_message "$GREEN" "✅ Aliases já configurados em $shell_rc"
  fi

  # Adicionar ~/bin ao PATH se não existir
  mkdir -p "$HOME/.bin"
  if ! grep -q 'PATH="$HOME/.bin:$PATH"' "$shell_rc"; then
    echo 'export PATH="$HOME/.bin:$PATH"' >>"$shell_rc"
    print_message "$GREEN" "✅ $HOME/.bin adicionado ao PATH em $shell_rc"
  fi

  # Adicionar completions
  # ZSH completions
  if [[ "$SHELL" == *"zsh"* ]]; then
    if command -v tmuxinator &>/dev/null; then
      tmuxinator completions zsh >"$HOME/.bin/tmuxinator.zsh"
      if ! grep -q "source.*tmuxinator.zsh" "$shell_rc"; then
        echo "source $HOME/.bin/tmuxinator.zsh" >>"$shell_rc"
      fi
    fi
  # Bash completions
  elif [[ "$SHELL" == *"bash"* ]]; then
    if command -v tmuxinator &>/dev/null; then
      tmuxinator completions bash >"$HOME/.bin/tmuxinator.bash"
      if ! grep -q "source.*tmuxinator.bash" "$shell_rc"; then
        echo "source $HOME/.bin/tmuxinator.bash" >>"$shell_rc"
      fi
    fi
  fi

  print_message "$GREEN" "✅ Completions configuradas"
}

# Instalar templates Tmuxinator
install_templates() {
  print_message "$BLUE" "Instalando templates Tmuxinator..."

  local template_dir="$HOME/.config/tmuxinator"
  mkdir -p "$template_dir"

  # Web Frontend Template
  cat >"$template_dir/web-frontend.yml" <<'EOF'
# ~/.config/tmuxinator/web-frontend.yml
# Template Tmuxinator para Desenvolvimento Web Frontend (React, Vue, Angular)

name: <%= @args[0] %>
root: <%= @args[1] || "~/projects/#{@args[0]}" %>

# Configurações de projeto - Altere conforme necessário
on_project_first_start: yarn install
on_project_restart: yarn install
on_project_stop: docker-compose down
on_project_exit: echo "Projeto encerrado: <%= @args[0] %>"
tmux_command: tmux -2

# Layout otimizado para desenvolvimento web
windows:
  - editor:
      # Layout com editor principal e terminal secundário
      layout: main-vertical
      panes:
        - nvim # Editor principal
        - # Terminal para comandos rápidos
          
  - servers:
      # Servidores de desenvolvimento e assets
      layout: even-horizontal
      panes:
        - yarn dev # Servidor de desenvolvimento (ajuste para npm start/npm run dev conforme necessário)
        - yarn storybook # Storybook para componentes

  - tests:
      # Testes e validação
      layout: even-horizontal
      panes:
        - yarn test:watch # Testes unitários
        - yarn lint:watch # Linter

  - git:
      # Controle de versão e logs
      layout: even-horizontal
      panes:
        - lazygit # Interface TUI para Git
        - # Terminal para log/histórico

  - monitoring:
      # Monitoramento de recursos e performance
      layout: even-horizontal  
      panes: 
        - yarn build:analyze # Analisador de bundle (ajuste conforme sua configuração)
        - htop # Monitor de recursos
EOF
  print_message "$GREEN" "✅ Template web-frontend.yml instalado"

  # Mobile (React Native) Template
  cat >"$template_dir/mobile-react-native.yml" <<'EOF'
# ~/.config/tmuxinator/mobile-react-native.yml
# Template Tmuxinator para Desenvolvimento Mobile com React Native

name: <%= @args[0] %>
root: <%= @args[1] || "~/projects/#{@args[0]}" %>

# Configurações de projeto
on_project_first_start: yarn install
on_project_restart: yarn install
tmux_command: tmux -2

# Layout otimizado para desenvolvimento mobile
windows:
  - editor:
      # Layout com editor principal e terminal secundário
      layout: main-vertical
      panes:
        - nvim # Editor principal
        - # Terminal para comandos rápidos
          
  - metro:
      # Metro bundler e emuladores
      layout: even-horizontal
      panes:
        - yarn start # Metro bundler
        - echo "Comandos úteis:
          - yarn android (iniciar app no Android)
          - yarn ios (iniciar app no iOS)
          - yarn lint (verificar código)
          - yarn test (executar testes)"

  - simulators:
      # Controle de emuladores/simuladores
      layout: even-horizontal
      panes:
        - # Comandos Android
          echo "Comandos Android:
          - emulator -list-avds (listar AVDs)
          - emulator -avd [nome] (iniciar emulador)
          - adb devices (listar dispositivos)
          - adb logcat (ver logs)"
        - # Comandos iOS
          echo "Comandos iOS:
          - xcrun simctl list (listar simuladores)
          - xcrun simctl boot [nome] (iniciar simulador)
          - xcrun simctl log [nome] (ver logs)"

  - tests:
      # Testes e análise de código
      layout: even-horizontal
      panes:
        - yarn test:watch # Testes unitários
        - # Terminal para debugging

  - git:
      # Controle de versão
      layout: even-horizontal
      panes:
        - lazygit # Interface TUI para Git
        - # Terminal para revisar mudanças
EOF
  print_message "$GREEN" "✅ Template mobile-react-native.yml instalado"

  # Backend (Node.js) Template
  cat >"$template_dir/backend-nodejs.yml" <<'EOF'
# ~/.config/tmuxinator/backend-nodejs.yml
# Template Tmuxinator para Desenvolvimento Backend com Node.js

name: <%= @args[0] %>
root: <%= @args[1] || "~/projects/#{@args[0]}" %>

# Configurações de projeto
on_project_first_start: 
  - yarn install
  - docker-compose up -d
on_project_restart: docker-compose restart
on_project_stop: docker-compose down
tmux_command: tmux -2

# Layout otimizado para desenvolvimento backend
windows:
  - editor:
      # Layout com editor principal e terminal secundário
      layout: main-vertical
      panes:
        - nvim # Editor principal
        - # Terminal para comandos rápidos
          
  - server:
      # Servidor e API
      layout: even-horizontal
      panes:
        - yarn dev # Servidor de desenvolvimento
        - # Terminal para testes de API
          echo "Comandos úteis:
          - curl (testar endpoints)
          - http (HTTPie)
          - jq (formatar JSON)
          - ab (benchmark de API)"

  - database:
      # Gestão de banco de dados
      layout: even-horizontal
      panes:
        - docker-compose ps # Status dos containers
        - # Terminal para comandos DB
          echo "Comandos úteis:
          - docker-compose logs -f db (logs do banco)
          - mongosh (cli MongoDB)
          - psql (cli PostgreSQL)
          - mysql (cli MySQL)
          - redis-cli (cli Redis)"

  - tests:
      # Testes e documentação
      layout: tiled
      panes:
        - yarn test:watch # Testes unitários
        - yarn test:e2e # Testes E2E
        - # Terminal para testes de carga
        - # Terminal para cobertura de código

  - logs:
      # Logs e monitoramento
      layout: even-horizontal
      panes:
        - yarn logs # Logs do servidor (ajuste para seu projeto)
        - htop # Monitor de recursos
EOF
  print_message "$GREEN" "✅ Template backend-nodejs.yml instalado"

  # Fullstack (Next.js) Template
  cat >"$template_dir/fullstack-nextjs.yml" <<'EOF'
# ~/.config/tmuxinator/fullstack-nextjs.yml
# Template Tmuxinator para Desenvolvimento Fullstack com Next.js

name: <%= @args[0] %>
root: <%= @args[1] || "~/projects/#{@args[0]}" %>

# Configurações de projeto
on_project_first_start: 
  - yarn install
  - docker-compose up -d
on_project_restart: 
  - docker-compose restart
  - yarn prisma generate
on_project_stop: docker-compose down
tmux_command: tmux -2

# Layout otimizado para desenvolvimento fullstack
windows:
  - editor:
      # Layout com editor principal para código
      layout: main-vertical
      panes:
        - nvim # Editor principal
        - # Terminal para comandos rápidos
          
  - frontend:
      # Desenvolvimento do frontend
      layout: even-horizontal
      panes:
        - yarn dev # Servidor de desenvolvimento Next.js
        - # Terminal para gestão de componentes
          echo "Comandos úteis:
          - yarn storybook (iniciar Storybook)
          - yarn analyze (analisar bundle)
          - yarn cypress (testes E2E)"

  - backend:
      # Desenvolvimento do backend/API
      layout: even-horizontal
      panes:
        - # Terminal para gestão de API
          echo "Comandos úteis:
          - yarn prisma studio (interface BD)
          - yarn prisma migrate (migrar BD)
          - yarn seed (popular BD)"
        - # Terminal para logs e debug API
          echo "Comandos úteis:
          - yarn logs:api (ver logs)
          - yarn trace:api (ver traces)"

  - database:
      # Gestão de banco de dados
      layout: even-horizontal
      panes:
        - docker-compose ps # Status dos containers
        - # Terminal para comandos diretos DB
          echo "Bancos de dados:
          - PostgreSQL: psql -U postgres -h localhost
          - MySQL: mysql -u root -p
          - MongoDB: mongosh
          - Redis: redis-cli"

  - tests:
      # Testes e validação
      layout: tiled
      panes:
        - yarn test:unit # Testes unitários
        - yarn test:integration # Testes de integração 
        - yarn lint # Linting do código
        - yarn typecheck # Verificação de tipos (TypeScript)

  - ops:
      # DevOps e deployment
      layout: even-horizontal
      panes:
        - lazygit # Interface Git
        - # Terminal para deployment
          echo "Comandos de deployment:
          - yarn build (construir para produção)
          - yarn deploy:vercel (deploy para Vercel)
          - yarn docker:build (construir imagem)
          - yarn docker:push (enviar imagem)"
EOF
  print_message "$GREEN" "✅ Template fullstack-nextjs.yml instalado"

  # Script auxiliar para criar novos projetos
  cat >"$HOME/.bin/create-project" <<'EOF'
#!/bin/bash

# Script para criar novos projetos a partir de templates Tmuxinator

# Verifica argumentos
if [ "$#" -lt 2 ]; then
  echo "Uso: create-project <tipo> <nome> [caminho]"
  echo "  <tipo>: web-frontend, mobile-react-native, backend-nodejs, fullstack-nextjs"
  echo "  <nome>: Nome do projeto"
  echo "  [caminho]: Caminho do projeto (opcional)"
  exit 1
fi

tipo="$1"
nome="$2"
caminho="${3:-$HOME/projects/$nome}"

# Verifica se o template existe
if [ ! -f "$HOME/.config/tmuxinator/$tipo.yml" ]; then
  echo "Erro: Template '$tipo' não encontrado!"
  echo "Templates disponíveis:"
  ls -1 "$HOME/.config/tmuxinator/"*.yml | xargs -n1 basename | sed 's/\.yml$//'
  exit 1
fi

# Cria o diretório do projeto se não existir
mkdir -p "$caminho"

# Cria o projeto Tmuxinator
tmuxinator new "$nome" --project-config="$HOME/.config/tmuxinator/$tipo.yml" "$nome" "$caminho"

echo "Projeto '$nome' criado com sucesso!"
echo "Para iniciar: tmuxinator start $nome"
EOF
  chmod +x "$HOME/.bin/create-project"

  print_message "$GREEN" "✅ Script utilitário create-project instalado em ~/.bin/create-project"
}

# Configurar integração com Neovim
configure_neovim_integration() {
  print_message "$BLUE" "Configurando integração com Neovim..."

  # Verificar se Neovim está instalado
  if ! command -v nvim &>/dev/null; then
    print_message "$YELLOW" "Neovim não encontrado, pulando configuração de integração."
    return 0
  fi

  # Local do arquivo de configuração
  local nvim_config_dir="$HOME/.config/nvim"
  if [ ! -d "$nvim_config_dir" ]; then
    print_message "$YELLOW" "Diretório de configuração do Neovim não encontrado: $nvim_config_dir"
    print_message "$YELLOW" "Pulando configuração de integração Neovim-Tmux."
    return 0
  fi

  # Criar diretório de plugins se não existir
  mkdir -p "$nvim_config_dir/lua/plugins"

  # Criar plugin de integração Tmux-Neovim
  local integration_file="$nvim_config_dir/lua/plugins/tmux.lua"

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

  print_message "$GREEN" "✅ Integração com Neovim configurada"
  print_message "$YELLOW" "Nota: Você precisará reiniciar o Neovim para aplicar as alterações"
}

# Criar guia de uso
create_usage_guide() {
  print_message "$BLUE" "Criando guia de uso..."

  # Modificado: Agora o guia será salvo em ~/.config/tmuxinator/README.md
  local guide_file="$HOME/.config/tmuxinator/README.md"

  cat >"$guide_file" <<'EOF'
# Guia de Uso do Tmuxinator para Desenvolvimento

Este guia fornece instruções detalhadas sobre como usar o Tmuxinator para gerenciar seus ambientes de desenvolvimento.

## Comandos Básicos

```bash
# Iniciar um projeto
tmuxinator start projeto
# ou usando o alias
mux start projeto

# Listar projetos
tmuxinator list
# ou usando o alias
txl

# Criar um novo projeto a partir de template
create-project web-frontend projeto-web ~/projetos/projeto-web

# Parar um projeto
tmuxinator stop projeto

# Editar configuração de projeto
tmuxinator edit projeto
```

## Templates Disponíveis

Os seguintes templates estão disponíveis:

- `web-frontend`: Para desenvolvimento web frontend (React, Vue, Angular)
- `mobile-react-native`: Para desenvolvimento mobile com React Native
- `backend-nodejs`: Para desenvolvimento backend com Node.js
- `fullstack-nextjs`: Para desenvolvimento fullstack com Next.js

## Atalhos do Tmux

Com o prefixo `Ctrl-a`:

- `Ctrl-a c`: Criar nova janela
- `Ctrl-a n`: Próxima janela
- `Ctrl-a p`: Janela anterior
- `Ctrl-a %`: Dividir painel verticalmente
- `Ctrl-a "`: Dividir painel horizontalmente
- `Ctrl-a h/j/k/l`: Navegar entre painéis
- `Ctrl-a d`: Desanexar da sessão
- `Ctrl-a [`: Entrar no modo de cópia
- `Ctrl-a ?`: Listar todos os atalhos

## Uso com WezTerm e Neovim

Para uma experiência perfeita entre WezTerm, Tmux e Neovim:

1. **WezTerm**: Gerencia a janela do terminal e configurações de aparência
2. **Tmux**: Gerencia sessões, janelas e painéis persistentes
3. **Neovim**: Editor de código com integração de navegação

Use `Ctrl-h/j/k/l` para navegar entre painéis do Tmux e janelas do Neovim.

## Personalização

Você pode modificar os templates em `~/.config/tmuxinator/` para adaptá-los às suas necessidades.

Para mais informações, consulte a [documentação oficial do Tmuxinator](https://github.com/tmuxinator/tmuxinator).
EOF

  print_message "$GREEN" "✅ Guia de uso criado: $guide_file"
}

# Função principal
main() {
  print_message "$MAGENTA" "===== Instalação Completa do Tmuxinator ====="

  # Verificar dependências
  check_dependencies

  # Instalar Tmuxinator
  install_tmuxinator

  # Configurar shell
  setup_shell_integration

  # Instalar templates
  install_templates

  # Configurar integração com Neovim
  configure_neovim_integration

  # Criar guia de uso
  create_usage_guide

  print_message "$MAGENTA" "===== Instalação Completa do Tmuxinator Concluída ====="
  print_message "$GREEN" "Para começar a usar, você pode:"
  print_message "$CYAN" "  - Carregar as configurações do shell: source ~/.bashrc (ou ~/.zshrc)"
  print_message "$CYAN" "  - Criar um novo projeto: create-project <tipo> <nome> [caminho]"
  print_message "$CYAN" "  - Iniciar um projeto: tmuxinator start <nome>"
  print_message "$CYAN" "  - Consultar o guia: ~/.config/tmuxinator/README.md"
}

# Executar função principal
main
