#!/bin/bash

case "$1" in
    --next) 
        if mpc next; then
            notify-send -h string:x-dunst-stack-tag:mpdsong "Now playing" "$(mpc current)"
        else
            nofiy-send -u critical "Couldn't change mpd song"
        fi
        ;;
    --prev)
        if mpc prev; then
            notify-send -h string:x-dunst-stack-tag:mpdsong "Now playing" "$(mpc current)"
        else
            notif-send -u critical "Couldn't change mpd song"
        fi
        ;;
    *) exit ;;
esac
