## Fish config

# Base16 Shell
if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"
end

# Default editor
set -x EDITOR nvim

# GPG tty
set -x GPG_TTY (tty)

# Custom path: don't set this here,
# just update whenever you want to change
# user paths, they are persisted.
# You should append new user paths with
#   set -Ua fish_user_paths <path1> <path2> ...
# Check current path with
#   set --show fish_user_paths

# ripgrep conf
set -x RIPGREP_CONFIG_PATH $HOME/.ripgreprc

# Custom aliases
alias l='ls --color=always -lF | less -r'
alias lt='ls -ltra'
alias vi='nvim'

# Wayland
set -x MOZ_ENABLE_WAYLAND 1
set -x BEMENU_BACKEND wayland

# SSG agent
set -x SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"

# Start window manager
if test -z "$DISPLAY"; and test (tty) = '/dev/tty1'
    XKB_DEFAULT_LAYOUT=us exec sway > $HOME/.sway.log 2>&1
end
