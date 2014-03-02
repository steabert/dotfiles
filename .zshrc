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

source /usr/share/doc/fzf/examples/key-bindings.zsh
fzf-and-run-widget() {
	fzf-history-widget
  zle accept-line
}
zle     -N   fzf-and-run-widget
bindkey '^R' fzf-and-run-widget

# Custom aliases
alias ls='ls --color=always'
alias ll='ls -lFa'
alias lt='ll -tr'
alias cdi='cd $(fd -t d | fzf)'
alias ho='hx $(fd . | fzf)'

# Environment
export EDITOR=hx
export GPG_TTY=$(tty)
export FZF_DEFAULT_COMMAND='fd --type f --no-ignore-vcs'
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
export MOZ_ENABLE_WAYLAND=1

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
PROMPT='[%F{red}${PROMPT_PREFIX}%f%n@%F{yellow}%m%f %F{blue}%16<…<%~%<<%f %F{green}${vcs_info_msg_0_}%f]%# '
