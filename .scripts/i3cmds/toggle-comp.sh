#!/bin/bash
COMP_NAME="picom"
proc_pid="$(pgrep $COMP_NAME)"

if [ -z "$proc_pid" ]; then
    if picom -b; then
        notify-send -h string:x-dunst-stack-tag:comptoggle "$COMP_NAME started"
    else
        notify-send -u critical "Couldn't start $COMP_NAME"
        exit 1;
    fi
else
    if kill -9 "$proc_pid" 2>/dev/null; then
        while pgrep -u "$UID" -x "$COMP_NAME" >/dev/null; do sleep 1; done
        notify-send -h string:x-dunst-stack-tag:comptoggle "$COMP_NAME killed"
    else
        notify-send -u critical "Couldn't kill $COMP_NAME"
        exit 1;
    fi
fi
