#!/bin/bash
STEP=5

set_vol() {
    if mpc volume "$1"; then
        new_volume=$(mpc status '%volume%')
        new_volume="${new_volume//[^0-9]/}"
        notify-send -i audio-volume-high-symbolic -h string:x-dunst-stack-tag:mpdvolume -h int:value:"$new_volume" "MPD Volume changed" "Volume: ${new_volume}%"
    else
        notify-send -u critical "Couldn't set mpd volume"
    fi
}

case "$1" in
    --inc) set_vol "+$STEP" ;;
    --dec) set_vol "-$STEP" ;;
    *) exit ;;
esac
