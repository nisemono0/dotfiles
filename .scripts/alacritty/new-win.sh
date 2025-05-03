#!/bin/bash

case "$1" in
    --vertical)
        i3-msg split vertical
        alacritty msg create-window --working-directory="${PWD}"
        ;;
    --horizontal)
        i3-msg split horizontal
        alacritty msg create-window --working-directory="${PWD}"
        ;;
    *) exit 1 ;;
esac
