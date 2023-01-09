#!/bin/bash

#xinput --list
MOUSE_NAME=""
PROP_NAME="libinput Accel Speed"
STEP=0.1

[ $# -ne 1 ] && echo "Too few/many arguments, expecting 1" && exit 1

speed=$(xinput --list-props "$MOUSE_NAME" | awk -F ':' -v PROP_NAME="$PROP_NAME" 'index($0, PROP_NAME) {print $2}' | head -n 1)

case "$1" in
    -i|--inc) # Increase by STEP
        newspeed=$(bc <<< "$speed + $STEP")
        [ "$(bc <<< "$newspeed > 1")" = 1 ] && notify-send "Mouse speed is already at max" && exit 1
        if xinput --set-prop "$MOUSE_NAME" "$PROP_NAME" "$newspeed"; then
            notify-send "Mouse speed increased" "Speed: $newspeed"
        else
            notify-send -u critical "Couldn't set mouse speed"
        fi
        ;;
    -d|--dec) # Decrease by STEP
        newspeed=$(bc -l <<< "$speed - $STEP")
        [ "$(bc <<< "$newspeed < -1")" = 1 ] && notify-send "Mouse speed is already at min" && exit 1
        if xinput --set-prop "$MOUSE_NAME" "$PROP_NAME" "$newspeed"; then
            notify-send "Mouse speed decreased" "Speed: $newspeed"
        else
            notify-send -u critical "Couldn't set mouse speed"
        fi
        ;;
    -r|--reset) # Reset
        if xinput --set-prop "$MOUSE_NAME" "$PROP_NAME" 0.0; then
            notify-send "Mouse speed reset" "Speed: 0.0"
        else
            notify-send -u critical "Couldn't set mouse speed"
        fi
        ;;
    *)
        echo "$0 <-i,--inc | -d,--dec | -r,--reset>"
        exit 1
        ;;
esac
