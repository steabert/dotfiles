#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# enable vi key bindings
set -o vi

# disable flow control XON/XOFF
stty -ixon

# some convenient aliases
alias ls='ls --color=auto'
alias la='ls -aF'
alias ll='ls -lF'
alias lt='ls -ltr'

# my bash prompt
PS1='[\u@\h \W]\$ '

# larger history
export HISTSIZE=10000
# ignore repeated entries
export HISTCONTROL=ignoredups
# ignore cluttering
export HISTIGNORE="clear:history"

# Perl modules
export PERL_LOCAL_LIB_ROOT="$PERL_LOCAL_LIB_ROOT:$HOME/perl5";
export PERL_MB_OPT="--install_base $HOME/perl5";
export PERL_MM_OPT="INSTALL_BASE=$HOME/perl5";
export PERL5LIB="$HOME/perl5/lib/perl5:$PERL5LIB";
export PATH="$HOME/perl5/bin:$PATH";

# Molcas environment
export MOLCAS_PROJECT='NAME'
export MOLCAS_WORKDIR='/tmp'
