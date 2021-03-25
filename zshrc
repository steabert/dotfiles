# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt extendedglob
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/stevenv/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Default editor
export EDITOR=nvim

# GPG tty
export GPG_TTY=$(tty)

# find utilities
export FZF_DEFAULT_COMMAND='fd --type f --no-ignore-vcs'
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

# Custom aliases
alias ls='ls --color=always'
alias ll='ls -lFa'
alias lt='ll -tr'
alias vi='nvim'

# Wayland
export MOZ_ENABLE_WAYLAND=1
export BEMENU_BACKEND=wayland

# SSG agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Prompt
autoload -Uz promptinit && promptinit && prompt redhat
PROMPT='[%n@%F{yellow}%m%f %F{blue}%B%1~%b%f]$ '

# History search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search
