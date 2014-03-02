typeset -U PATH path
path=(
        $HOME/.deno/bin
        $HOME/.azure/bin
        $HOME/go/bin
        /usr/local/go/bin
        $HOME/.cargo/bin
        $HOME/.local/bin
        $HOME/bento4/bin
        $HOME/.fzf/bin
        $HOME/.yarn/bin
        $HOME/.luarocks/bin
        $HOME/bin "$path[@]"
)
export PATH
# fix "less" behaviour from /etc/zsh/zshenv default
# - change R -> r
# - disable e (quits att EOF)
export LESS=dMqifr
# - change latin1 -> utf-8
export LESSCHARSET=utf-8
