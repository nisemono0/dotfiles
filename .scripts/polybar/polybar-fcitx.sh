#!/bin/bash

get_input_name() {
    current_input="$(dbus-send --session --print-reply --dest=org.fcitx.Fcitx /inputmethod \
    org.freedesktop.DBus.Properties.Get \
        string:org.fcitx.Fcitx.InputMethod \
        string:CurrentIM \
    | grep string | cut -d'"' -f2)"

    if [[ "$current_input" = "mozc" ]]; then
        echo "jp"
    else
        echo "en"
    fi
}

react() {
    get_input_name
    while true; do
        read -r
        get_input_name
    done
}

gdbus monitor --session --dest org.fcitx.Fcitx --object-path /inputmethod | grep --line-buffered / | react