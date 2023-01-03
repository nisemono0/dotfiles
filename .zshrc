# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/$USER/.config/oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
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

alias l="ls -lahv"
alias la="ls -lAhv"
alias ll="ls -lhv"
alias ls="ls --color=tty -v"

alias _="sudo -E"
alias sudo="sudo -E"
alias shutdown="sudo shutdown now"
alias reboot="sudo reboot"

