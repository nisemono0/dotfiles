#!/bin/bash
. $HOME/.dmenurc

WALLCHANGE="$(dirname "$0")/wall-change.sh"

start_slideshow() {
    stop_slideshow

    if systemctl --user start "wallpaper-slideshow@$1.timer"; then
        notify-send -h string:x-dunst-stack-tag:wallpaperslideshow "Wallpaper slideshow $1 started"
    else
        notify-send -u critical "Error starting wallpaper-slideshow@$1.timer"
    fi
}

start_menu() {
    case $(printf "All\\nSafe\\nQuestionable\\nExplicit" | dmenu $DMENU_OPTIONS -fn "$DMENU_FN" -p "Slideshow type") in
        "All") start_slideshow "all" ;;
        "Safe") start_slideshow "s" ;;
        "Questionable") start_slideshow "q" ;;
        "Explicit") start_slideshow "e" ;;
        *) exit ;;
    esac
}

stop_slideshow() {
    if systemctl --user stop "wallpaper-slideshow@*.timer"; then
        notify-send -h string:x-dunst-stack-tag:wallpaperslideshow "Wallpaper slideshow stopped"
    else
        notify-send -u critical "Error stopping wallpaper-slideshow@*.timer"
    fi
}

next_wallpaper() {
    if systemctl --user is-active wallpaper-slideshow@all.timer; then
        systemctl --user restart wallpaper-slideshow@all.timer
    elif systemctl --user is-active wallpaper-slideshow@s.timer; then
        systemctl --user restart wallpaper-slideshow@s.timer
    elif systemctl --user is-active wallpaper-slideshow@q.timer; then
        systemctl --user restart wallpaper-slideshow@q.timer
    elif systemctl --user is-active wallpaper-slideshow@e.timer; then
        systemctl --user restart wallpaper-slideshow@e.timer
    else
        notify-send -h string:x-dunst-stack-tag:wallpaperslideshow "Slideshow must be running"
    fi
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

case $(printf "Start\\nStop\\nChange colors\\nCopy to\\nCopy clipboard\\nNext image\\nReset" | dmenu $DMENU_OPTIONS -fn "$DMENU_FN" -p "Wallpaper slideshow") in
    "Start") start_menu ;;
    "Stop") stop_slideshow ;;
    "Change colors") change_colors ;;
    "Copy to") copy_to ;;
    "Copy clipboard") copy_clipboard ;;
    "Next image") next_wallpaper ;;
    "Reset") reset_wallpaper ;;
    *) exit ;;
esac
