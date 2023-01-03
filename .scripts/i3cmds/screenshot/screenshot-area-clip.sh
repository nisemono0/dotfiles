#!/usr/bin/bash

scr="/tmp/screenshot-area-clip.png"
if maim --hidecursor --capturebackground --select --bordersize 2 "$scr" 2>/dev/null; then
	xclip -selection clipboard -target image/png -i "$scr" && \
	notify-send "Screenshot saved in clipboard" -i "$scr" && \
	rm "$scr"
fi
