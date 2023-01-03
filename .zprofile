#
# ~/.zprofile
#

##### Environment variables #####
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/history"
export LESSHISTFILE="-"
export MPD_HOST="/tmp/mpd.socket"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export WEECHAT_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/weechat"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump-${HOST}-${ZSH_VERSION}"
export PATH="$PATH:${$(find ~/.local/bin -type d -printf %p:)%%:}"

# Load .zshrc file
[[ -f ~/.zshrc ]] && . ~/.zshrc

# Start i3 on tty1 after login if it isnt already running
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x i3 >/dev/null && exec startx

