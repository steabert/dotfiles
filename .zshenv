typeset -U PATH path
path=(
        $HOME/.local/bin
        $HOME/.npm-global/bin
        $HOME/go/bin
        "$path[@]"
)

. "$HOME/.cargo/env"

export PATH

# fix "less" behaviour from /etc/zsh/zshenv default
# - change R -> r
# - disable e (quits att EOF)
export LESS=dMqifr

# - change latin1 -> utf-8
export LESSCHARSET=utf-8

export LANG=en_US.utf8
export LANGUAGE=en_US.utf8
export LC_ALL=en_US.utf8
