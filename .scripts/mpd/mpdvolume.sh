#!/bin/bash

STEP=5
DUNST_ICON="audio-volume-high-symbolic"
VOLUME=$(mpc status '%volume%')
VOLUME="${VOLUME//[^0-9]/}"

update_vars() {
    VOLUME=$(mpc status '%volume%')
    VOLUME="${VOLUME//[^0-9]/}"
    DUNST_ICON="audio-volume-muted-symbolic"
    if (( VOLUME > 0 && VOLUME <= 35 )); then
        DUNST_ICON="audio-volume-low-symbolic"
    elif (( VOLUME > 35 && VOLUME <= 70 )); then
        DUNST_ICON="audio-volume-medium-symbolic"
    elif (( VOLUME > 70 && VOLUME <= 100 )); then
        DUNST_ICON="audio-volume-high-symbolic"
    fi
}

set_vol() {
    if mpc volume "$1"; then
        update_vars
        notify-send -i "$DUNST_ICON" -h string:x-dunst-stack-tag:mpdvolume -h int:value:"$VOLUME" "MPD Volume" "Volume: ${VOLUME}%"
    else
        notify-send -u critical "Couldn't set mpd volume"
    fi
}

case "$1" in
    --inc) set_vol "+$STEP" ;;
    --dec) set_vol "-$STEP" ;;
    *) exit ;;
esac
