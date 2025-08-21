#!/bin/bash

STEP=5
DUNST_ICON="audio-volume-high-symbolic"
IS_MUTED=$(pamixer --get-mute)
VOLUME=$(pamixer --get-volume)

update_vars() {
    IS_MUTED=$(pamixer --get-mute)
    VOLUME=$(pamixer --get-volume)

    if [ "$IS_MUTED" = "false" ]; then
        DUNST_ICON="audio-volume-muted-symbolic"
        if (( VOLUME > 0 && VOLUME <= 35 )); then
            DUNST_ICON="audio-volume-low-symbolic"
        elif (( VOLUME > 35 && VOLUME <= 70 )); then
            DUNST_ICON="audio-volume-medium-symbolic"
        elif (( VOLUME > 70 && VOLUME <= 100 )); then
            DUNST_ICON="audio-volume-high-symbolic"
        fi
    elif [ "$IS_MUTED" = "true" ]; then
        DUNST_ICON="audio-volume-muted-symbolic"
    fi
}

audio_mute() {
    if pamixer --toggle-mute; then
        update_vars
        if [ "$IS_MUTED" = "true" ]; then
            notify-send -i "$DUNST_ICON" -h string:x-dunst-stack-tag:sysaudio -h int:value:"$VOLUME" "Audio" "Muted"
        elif [ "$IS_MUTED" = "false" ]; then
            notify-send -i "$DUNST_ICON" -h string:x-dunst-stack-tag:sysaudio -h int:value:"$VOLUME" "Audio" "Unmuted"
        fi
    else
        notify-send -u critical "Couldn't mute system audio"
    fi
}

audio_vol() {
    if pamixer "$1" "$STEP"; then
        update_vars
        notify-send -i "$DUNST_ICON" -h string:x-dunst-stack-tag:sysaudio -h int:value:"$VOLUME" "Audio" "Volume: ${VOLUME}%"
    else
        notify-send -u critical "Couldn't mute system audio"
    fi
}

case "$1" in
    --mute) audio_mute ;;
    --vol-inc) audio_vol "--increase" ;;
    --vol-dec) audio_vol "--decrease" ;;
    *) exit ;;
esac
