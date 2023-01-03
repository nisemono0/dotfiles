#!/usr/bin/bash

scr="/tmp/screenshot-clip.png"
if maim --hidecursor --capturebackground "$scr" 2>/dev/null; then
    xclip -selection clipboard -target image/png -i "$scr" && \
    notify-send "Screenshot saved in clipboard" -i "$scr" && \
    rm "$scr"
fi