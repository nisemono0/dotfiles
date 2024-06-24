#!/bin/bash

get_input_name() {
    #current_input="$(gdbus call --session --dest org.fcitx.Fcitx --object-path /inputmethod --method org.fcitx.Fcitx.InputMethod.GetCurrentIM | grep -oP "(?<=').*(?=')")"
    current_input="$(fcitx-remote)"

    case "$current_input" in
        "1") echo "en" ;;
        "2") echo "jp" ;;
        *) echo "??" ;;
    esac
}

react() {
    get_input_name
    while true; do
        read -r
        get_input_name
    done
}

case "$1" in
    --monitor)
        gdbus monitor --session --dest org.fcitx.Fcitx --object-path /inputmethod | grep --line-buffered / | react
        ;;
    --toggle)
        fcitx-remote -t
        ;;
    *) exit ;;
esac

