#
# ~/.zprofile
#

# Environment variables
export MPD_HOST=$HOME/.config/mpd/socket

# Load .zshrc file
[[ -f ~/.zshrc ]] && . ~/.zshrc

# Start i3 on tty1 after login if it isnt already running
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x i3 >/dev/null && exec startx

