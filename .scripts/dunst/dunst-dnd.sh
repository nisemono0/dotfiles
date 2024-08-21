#!/bin/bash

TIMEOUT=5

if [[ "$(dunstctl is-paused)" == "false" ]]; then
    notify-send -h string:x-dunst-stack-tag:dunstdnd "Dunst" "Paused"
    sleep "$TIMEOUT"
    dunstctl set-paused true
else
    dunstctl set-paused false
    notify-send -h string:x-dunst-stack-tag:dunstdnd "Dunst" "Resumed"
fi
