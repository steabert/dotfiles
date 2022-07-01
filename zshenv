fpath=(~/.zfunc $fpath)

typeset -U PATH path
path=(
        $HOME/.node/bin
        $HOME/.deno/bin
        $HOME/.azure/bin
        $HOME/go/bin
        /usr/local/go/bin
        $HOME/.cargo/bin
        $HOME/.local/bin
        $HOME/bento4/bin
        $HOME/.fzf/bin
        $HOME/.yarn/bin
        $HOME/.npm-global/bin
        $HOME/.luarocks/bin
        $HOME/.lua-language-server/bin
        $HOME/bin "$path[@]"
)
export PATH
# fix "less" behaviour from /etc/zsh/zshenv default
# - change R -> r
# - disable e (quits att EOF)
export LESS=dMqifr
# - change latin1 -> utf-8
export LESSCHARSET=utf-8
. "$HOME/.cargo/env"
