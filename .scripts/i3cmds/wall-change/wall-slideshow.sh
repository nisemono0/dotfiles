#!/bin/bash
. $HOME/.dmenurc

WALLCHANGE="$(dirname "$0")/wall-change.sh"

start_slideshow() {
    if systemctl --user start wallpaper-slideshow.timer; then
        notify-send -h string:x-dunst-stack-tag:wallpaperslideshow "Wallpaper slideshow started"
    else
        notify-send -u critical "Error starting wallpaper-slideshow.timer"
    fi
}

stop_slideshow() {
    if systemctl --user stop wallpaper-slideshow.timer; then
        notify-send -h string:x-dunst-stack-tag:wallpaperslideshow "Wallpaper slideshow stopped"
    else
        notify-send -u critical "Error stopping wallpaper-slideshow.timer"
    fi
}

enable_slideshow() {
    if systemctl --user enable wallpaper-slideshow.timer; then
        notify-send -h string:x-dunst-stack-tag:wallpaperslideshow "Wallpaper slideshow enabled"
    else
        notify-send -u critical "Error enabling wallpaper-slideshow.timer"
    fi
}

disable_slideshow() {
    if systemctl --user disable wallpaper-slideshow.timer; then
        notify-send -h string:x-dunst-stack-tag:wallpaperslideshow "Wallpaper slideshow disabled"
    else
        notify-send -u critical "Error disabling wallpaper-slideshow.timer"
    fi
}

random_wallpaper() {
    . "$WALLCHANGE" --random
}

reset_wallpaper() {
    stop_slideshow
    . "$WALLCHANGE" --reset
}

change_colors() {
    . "$WALLCHANGE" --change-colors
}

copy_to() {
    . "$WALLCHANGE" --copy-to
}

copy_clipboard() {
    . "$WALLCHANGE" --copy-clipboard
}

case $(printf "Start\\nStop\\nEnable\\nDisable\\nChange colors\\nCopy to\\nCopy clipboard\\nRandom\\nReset" | dmenu $DMENU_OPTIONS -fn "$DMENU_FN" -p "Wallpaper slideshow") in
    "Start") start_slideshow ;;
    "Stop") stop_slideshow ;;
    "Enable") enable_slideshow ;;
    "Disable") disable_slideshow ;;
    "Change colors") change_colors ;;
    "Copy to") copy_to ;;
    "Copy clipboard") copy_clipboard ;;
    "Random") random_wallpaper ;;
    "Reset") reset_wallpaper ;;
    *) exit ;;
esac