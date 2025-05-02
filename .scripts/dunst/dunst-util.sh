#!/bin/bash

dunst_dnd() {
    TIMEOUT=5

    if [[ "$(dunstctl is-paused)" == "false" ]]; then
        notify-send -h string:x-dunst-stack-tag:dunstdnd "Dunst" "Paused"
        sleep "$TIMEOUT"
        dunstctl set-paused true
    else
        dunstctl set-paused false
        notify-send -h string:x-dunst-stack-tag:dunstdnd "Dunst" "Resumed"
    fi
}

dunst_close() {
    dunstctl close &
}

dunst_history_pop() {
    dunstctl history-pop &
}

dunst_history_clear() {
    dunstctl history-clear && notify-send "History cleared"
}

dunst_context() {
    dunstctl context &
}

case "$1" in
    --close) dunst_close ;;
    --history-pop) dunst_history_pop ;;
    --history-clear) dunst_history_clear ;;
    --context) dunst_context ;;
    --dnd) dunst_dnd ;;
    *) exit 1 ;;
esac
