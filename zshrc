setopt extendedglob
unsetopt beep
bindkey -v

# Completion
zstyle :compinstall filename '/home/stevenv/.zshrc'
autoload -Uz compinit
compinit

# History
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt sharehistory
setopt histignoredups
bindkey '^R' history-incremental-search-backward

# Custom aliases
alias ls='ls --color=always'
alias ll='ls -lFa'
alias lt='ll -tr'
alias vim='nvim'
alias s3='aws s3 --profile adm6'
alias g='tsocks git'

# Environment
export EDITOR=nvim
export GPG_TTY=$(tty)
export FZF_DEFAULT_COMMAND='fd --type f --no-ignore-vcs'
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
export MOZ_ENABLE_WAYLAND=1
export BEMENU_BACKEND=wayland
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
unset LESS # restore default less behaviour
export YARN_HTTP_PROXY=$HTTP_PROXY
export YARN_HTTPS_PROXY=$HTTPS_PROXY
export ELECTRON_GET_USE_PROXY='1'
export GLOBAL_AGENT_HTTPS_PROXY='http://wwwproxy:3128'

# Prompt
autoload -Uz promptinit && promptinit
autoload -Uz vcs_info
precmd_title () { print -Pn "\e]0;$(basename $PWD)\a" }
precmd_vcs_info () { vcs_info }
precmd() {
	precmd_vcs_info
	precmd_title
}
setopt promptsubst
zstyle ':vcs_info:git:*' formats '%b'
#PROMPT='[%n@%F{yellow}%m%f %F{blue}%B%1~%b%f %F{green}${vcs_info_msg_0_}%f]%# '
PROMPT='[%n@%F{yellow}%m%f %F{blue}%16<…<%~%<<%f %F{green}${vcs_info_msg_0_}%f]%# '

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
       [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"
