#!/bin/bash

# brightnessctl --list
CLASS="backlight"

change_brightness(){
    new_value="$(brightnessctl --class="$CLASS" set 10%$1 | grep -i "current brightness" | awk -F "[()]" '{ print $2 }')"
    if [ -n "$new_value" ]; then
        notify-send -h string:x-dunst-stack-tag:backlight "Brightness changed" "$new_value" -i video-display
    else
        notify-send -h string:x-dunst-stack-tag:backlight -u critical "Couldn't change brightness"
    fi
}

case "$1" in
    --inc)
        change_brightness +
        ;;
    --dec)
        change_brightness -
        ;;
    *)  exit ;;
esac
