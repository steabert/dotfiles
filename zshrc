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
alias neo='nvim'

# Environment
export EDITOR=nvim
export GPG_TTY=$(tty)
export FZF_DEFAULT_COMMAND='fd --type f --no-ignore-vcs'
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
export MOZ_ENABLE_WAYLAND=1
export BEMENU_BACKEND=wayland
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
unset LESS # restore default less behaviour

# Prompt
autoload -Uz promptinit && promptinit
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt promptsubst
zstyle ':vcs_info:git:*' formats '%b'
PROMPT='[%n@%F{yellow}%m%f %F{blue}%B%1~%b%f %F{green}${vcs_info_msg_0_}%f]%# '

