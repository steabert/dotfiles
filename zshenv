fpath=(~/.zfunc $fpath)

typeset -U PATH path
path=(
        $HOME/.azure/bin
        $HOME/.cargo/bin
        $HOME/.deno/bin
        $HOME/.fzf/bin
        $HOME/.local/bin
        $HOME/.lua-language-server/bin
        $HOME/.luarocks/bin
        $HOME/.npm-global/bin
        $HOME/.pulumi/bin
        $HOME/.yarn/bin
        $HOME/go/bin
        $HOME/prog/bento4/bin
        $HOME/prog/delta-0.15.0-x86_64-unknown-linux-musl
        $HOME/prog/nvim-linux64/bin
        "$path[@]"
)
export PATH
# fix "less" behaviour from /etc/zsh/zshenv default
# - change R -> r
# - disable e (quits att EOF)
export LESS=dMqifr
# - change latin1 -> utf-8
export LESSCHARSET=utf-8
. "$HOME/.cargo/env"

export LANG=en_US.utf8
export LANGUAGE=en_US.utf8
export LC_ALL=en_US.utf8
