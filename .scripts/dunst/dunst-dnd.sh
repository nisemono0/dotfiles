#!/bin/bash

TIMEOUT=5

if [[ "$(dunstctl is-paused)" == "false" ]]; then
    notify-send -h string:x-dunst-stack-tag:dunstdnd "Dunst" "Pause enabled"
    sleep "$TIMEOUT"
    dunstctl set-paused true
else
    dunstctl set-paused false
    notify-send -h string:x-dunst-stack-tag:dunstdnd "Dunst" "Pause disabled"
fi
