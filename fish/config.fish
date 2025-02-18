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
set -x PATH ~/.docker/bin/ $PATH
set -x PATH ~/.local/share/mise/installs/node/20.17.0/bin $PATH

## Android SDK
# Configurar o caminho do Android SDK
set -x ANDROID_SDK_ROOT $HOME/android-sdk
set -x ANDROID_HOME $HOME/android-sdk

# Adicionar binários ao PATH
set -x PATH $ANDROID_SDK_ROOT/emulator $PATH
set -x PATH $ANDROID_SDK_ROOT/platform-tools $PATH
set -x PATH $ANDROID_SDK_ROOT/tools $PATH
set -x PATH $ANDROID_SDK_ROOT/tools/bin $PATH

# Alias para facilitar
alias adb="/mnt/c/Users/bgarc/AppData/Local/Android/Sdk/platform-tools/adb.exe"
alias emulator="emulator.exe"

function start-emulator
    emulator -avd $(emulator -list-avds | head -n 1) -no-snapshot-load &
end

set -x STARSHIP_CONFIG ~/.config/starship/starship.toml

starship init fish | source
enable_transience
/usr/bin/mise activate fish | source


# pnpm
set -gx PNPM_HOME "/home/vycros/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

