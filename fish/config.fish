function starship_transient_prompt_func
  starship module character
end

function starship_transient_rprompt_func
  starship module time
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -x PATH /usr/local/bin $PATH
set -x PATH ~/.local/share/mise/shims $PATH
set -x STARSHIP_CONFIG ~/.config/starship/starship.toml

starship init fish | source
enable_transience
/opt/homebrew/bin/mise activate fish | source

# pnpm
set -gx PNPM_HOME "/Users/bgmoura/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
