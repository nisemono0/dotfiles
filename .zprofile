#
# ~/.zprofile
#

##### Environment variables #####
export XDG_CONFIG_HOME="$HOME/.config"

# MPD
export MPD_HOST="127.0.0.1"
export MPD_PORT="6600"

# Weechat
export WEECHAT_HOME="$XDG_CONFIG_HOME/weechat"

# Load .zshrc file
[[ -f ~/.zshrc ]] && . ~/.zshrc

# Start i3 on tty1 after login if it isnt already running
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x i3 >/dev/null && exec startx

