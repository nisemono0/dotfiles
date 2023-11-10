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

alias l="ls -lahv --group-directories-first"
alias la="ls -lAhv --group-directories-first"
alias ll="ls -lhv --group-directories-first"
alias ls="ls --color=tty  --group-directories-first -v"

alias ip="ip -color=auto"

alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -vI"

# Install packages
alias pacin="sudo pacman -S"
alias pacind="sudo pacman -S --asdeps"
alias pacins="sudo pacman -Syu"
# Install local packages
alias pacinloc="sudo pacman -U"
alias pacinlocd="sudo pacman -U --asdeps"
# Remove package and deps, settings
alias pacrm="sudo pacman -Rsn"
# Search/display info of local package
alias pacloc="pacman -Qi"
alias paclocs="pacman -Qs"
# List orphan packages
alias paclsorphans="sudo pacman -Qtdq"
# Update/Upgrade
alias pacupd="sudo pacman -Sy"
alias pacupg="sudo pacman -Syu"
# Search/display info of repo package
alias pacrep="pacman -Si"
alias pacreps="pacman -Ss"
# List files in a package
alias pacls="pacman -Ql"
# Show package owner of file
alias pacown="pacman -Qo"

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
