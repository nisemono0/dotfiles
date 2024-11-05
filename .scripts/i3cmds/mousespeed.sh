#!/bin/bash

# xinput --list
MOUSE_NAME=""
PROP_NAME_SPEED="libinput Accel Speed"
PROP_NAME_ACCEL="libinput Accel Profile Enabled"
STEP=0.1

[ $# -ne 1 ] && echo "Too few/many arguments, expecting 1" && exit 1

speed=$(xinput --list-props "$MOUSE_NAME" | awk -F ':' -v PROP_NAME_SPEED="$PROP_NAME_SPEED" 'index($0, PROP_NAME_SPEED) { printf("%.3g %.3g\n", $1, $2) }' | head -n 1 | tr -d "[:blank:]")
accel=$(xinput --list-props "$MOUSE_NAME" | awk -F ':' -v PROP_NAME_ACCEL="$PROP_NAME_ACCEL" 'index($0, PROP_NAME_ACCEL) { print $2 }' | head -n 1 | tr -d "[:blank:]")

set_speed() {
    if [ "$(bc <<< "$newspeed > 1")" = 1 ]; then
        notify-send -h string:x-dunst-stack-tag:mouseopt "Mouse speed is at max" "Speed: $speed"
        exit 1
    elif [ "$(bc <<< "$newspeed < -1")" = 1 ]; then
        notify-send -h string:x-dunst-stack-tag:mouseopt "Mouse speed is at min" "Speed: $speed"
        exit 1
    else
        if xinput --set-prop "$MOUSE_NAME" "$PROP_NAME_SPEED" "$1"; then
            notify-send -h string:x-dunst-stack-tag:mouseopt "Mouse speed changed" "Speed: $1"
        else
            notify-send -u critical "Couldn't set mouse speed"
        fi
    fi
}

reset_speed() {
    if xinput --set-prop "$MOUSE_NAME" "$PROP_NAME_SPEED" 0.0; then
        notify-send -h string:x-dunst-stack-tag:mouseopt "Mouse speed reset" "Speed: 0 (Default)"
    else
        notify-send -u critical "Couldn't set mouse speed"
    fi
}

toggle_accel() {
    if [ "$accel" = "1,0" ] || [ "$accel" = "1,0,0" ]; then
        if xinput --set-prop "$MOUSE_NAME" "$PROP_NAME_ACCEL" 0, 1; then
            notify-send -h string:x-dunst-stack-tag:mouseopt "Mouse accel changed" "Accel: Flat (0, 1)"
        else
            notify-send -u critical "Couldn't change mouse accel"
        fi
    elif [ "$accel" = "0,1" ] || [ "$accel" = "0,1,0" ]; then
        if xinput --set-prop "$MOUSE_NAME" "$PROP_NAME_ACCEL" 1, 0; then
            notify-send -h string:x-dunst-stack-tag:mouseopt "Mouse accel changed" "Accel: Adaptive (1, 0)"
        else
            notify-send -u critical "Couldn't change mouse accel"
        fi
    else
        notify-send -u critical "No mouse accel found"
    fi
}

case "$1" in
    --inc) # Increase by STEP
        newspeed=$(bc <<< "$speed + $STEP")
        set_speed "$newspeed"
        ;;
    --dec) # Decrease by STEP
        newspeed=$(bc -l <<< "$speed - $STEP")
        set_speed "$newspeed"
        ;;
    --accel) # Toggle mouse accel profile
        toggle_accel
        ;;
    --reset) # Reset
        reset_speed
        ;;
    *)
        echo "$0 <--inc | --dec | --reset | --accel>"
        exit 1
        ;;
esac
