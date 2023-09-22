#!/bin/bash
STEP=5

set_vol() {
    if mpc volume "$1"; then
        notify-send -h string:x-dunst-stack-tag:mpdvolume "$(mpc status 'mpd volume:%volume%')"
    else
        notify-send -u critical "Couldn't set mpd volume"
    fi
}

case "$1" in
    --inc) set_vol "+$STEP" ;;
    --dec) set_vol "-$STEP" ;;
    *) exit ;;
esac
