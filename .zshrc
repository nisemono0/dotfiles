# Path to your oh-my-zsh installation.
export ZSH="/home/$USER/.config/oh-my-zsh"

ZSH_THEME="simple"

plugins=(git)

source $ZSH/oh-my-zsh.sh

ranger() {
    if [ -z "$RANGER_LEVEL" ]; then
        /usr/bin/ranger "$@"
    else
        exit
    fi
}

if [ -n "$RANGER_LEVEL" ]; then export PS1="(ranger) $PS1"; fi

calc() { awk "BEGIN{ print $* }" ;}

alias l="ls -lahv"
alias la="ls -lAhv"
alias ll="ls -lhv"
alias ls="ls --color=tty -v"

alias _="sudo -E"
alias sudo="sudo -E"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]='fg=green'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=green'
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=green'
ZSH_HIGHLIGHT_STYLES[command]='none'
ZSH_HIGHLIGHT_STYLES[alias]='none'
ZSH_HIGHLIGHT_STYLES[builtin]='none'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[unknown-token]='none,bold'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[named-fd]='fg=blue'
ZSH_HIGHLIGHT_STYLES[numeric-fd]='fg=blue'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=blue'
