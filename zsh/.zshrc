# echo 'export ZDOTDIR="$HOME/.config/zsh"' > ~/.zshenv
# Usar o arquivo .zshenv para definir o diretório de configuração
#
#
# Arquivo de configuração Zsh para desenvolvimento de alto desempenho
# Criado para substituir a configuração Fish

# ===[ Configurações básicas ]=== #
export TERM="xterm-256color"                # Suporte a cores completo
export EDITOR='nvim'                        # Neovim como editor padrão
export VISUAL='nvim'                        # Neovim para edição visual
export HISTFILE=~/.zsh_history              # Arquivo de histórico
export HISTSIZE=10000                       # Número de items no histórico
export SAVEHIST=10000                       # Número de items no histórico a salvar
setopt HIST_IGNORE_ALL_DUPS                 # Ignorar duplicatas no histórico
setopt HIST_SAVE_NO_DUPS                    # Não salvar duplicatas
setopt INC_APPEND_HISTORY                   # Adicionar comandos ao histórico imediatamente
setopt EXTENDED_HISTORY                     # Salvar timestamp
setopt HIST_EXPIRE_DUPS_FIRST               # Remover duplicatas primeiro quando HISTSIZE é excedido

# ===[ Path customizado ]=== #
# Adiciona homebrew ao PATH
export PATH="/opt/homebrew/bin:$PATH"
# Adiciona ~/.local/bin ao PATH
export PATH="$HOME/.local/bin:$PATH"

# ===[ Inicialização do Zinit ]=== #
# Framework para gerenciar plugins e completions
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load important annexes
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# ===[ Plugins de completions ]=== #
zinit ice blockf
autoload -Uz compinit
compinit
zinit cdreplay -q

# ===[ Suporte à compatibilidade com Fish ]=== #
# Esses plugins trazem funcionalidades do Fish para o Zsh

# Syntax highlighting (cores para comandos válidos)
zinit ice wait lucid
zinit light zdharma-continuum/fast-syntax-highlighting

# Sugestões baseadas no histórico como no Fish
zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions

# Completions mostrando documentação como no Fish
zinit ice wait lucid
zinit light clarketm/zsh-completions



# ===[ Ferramentas para desenvolvimento ]=== #
# fzf - fuzzy finder para busca interativa
if command -v fzf >/dev/null 2>&1; then
    zinit ice from"gh-r" as"program"
    zinit light junegunn/fzf
fi

# ===[ Aliases ]=== #
# Aliases do sistema
alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'

# Aliases do Git
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias glog='git log --oneline --graph --decorate'

# Aliases do Neovim
alias vi='nvim'
alias vim='nvim'
alias v='nvim'

# Aliases para navegação rápida
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ===[ Atalhos de teclado ]=== #
# Configurações de keybindings estilo Emacs
bindkey -e

# Busca no histórico com setas
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# Ctrl+R para busca reversa no histórico usando fzf
if [[ -n "$ZSH_VERSION" && -f ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh
fi

# ===[ Path e variáveis de ambiente ]=== #
# Suporte a MISE (gerenciador de versões)
eval "$(mise activate zsh)"

# Node Version Manager (nvm) - se instalado
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    . "$NVM_DIR/nvm.sh"  # Carrega nvm
fi
if [ -s "$NVM_DIR/bash_completion" ]; then
    . "$NVM_DIR/bash_completion"  # Carrega completions
fi

# Integração com PNPM
if command -v pnpm >/dev/null 2>&1; then
    export PNPM_HOME="$HOME/.local/share/pnpm"
    export PATH="$PNPM_HOME:$PATH"
fi

# ===[ Extras ]=== #
# Auto CD - muda de diretório sem digitar cd
setopt AUTO_CD

# Correção de comandos
setopt CORRECT
setopt CORRECT_ALL

# Completions melhoradas
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' verbose yes
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{green}%B-- %d --%b%f'
zstyle ':completion:*:messages' format '%F{yellow}%d%f'
zstyle ':completion:*:warnings' format '%F{red}-- sem correspondências --%f'
zstyle ':completion:*:corrections' format '%F{green}%B-- %d (erros: %e) --%b%f'

# Acelerar o sistema de completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' menu select

# Limpar o .zcompdump apenas uma vez por dia
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# ===[ Prompts e temas ]=== #
# Starship - prompt multi-shell customizável
export STARSHIP_CONFIG=~/.config/starship/starship.toml starship prompt
eval "$(starship init zsh)"

# Acelerar o prompt do Git
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# Cache git status para não verificar constantemente
function precmd() {
  if [ -n "$ZLUA_SCRIPT" ]; then
    (lua $ZLUA_SCRIPT --add "$(pwd)" &) > /dev/null 2>&1
  fi
}

# Remova duplicatas do PATH (adicione ao .zshrc)
typeset -U path

# Desabilite compinit verificando todos os possíveis aliases
unsetopt complete_aliases

