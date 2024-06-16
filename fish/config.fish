function starship_transient_prompt_func
  starship module time
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -x PATH /usr/local/bin $PATH
set -x STARSHIP_CONFIG ~/.config/starship/starship.toml
set -x OS Macos

starship init fish | source
enable_transience
