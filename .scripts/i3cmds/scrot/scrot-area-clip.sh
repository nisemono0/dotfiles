#!/usr/bin/bash
sleep 0.2 ; (scrot -o -s -f /tmp/scrot-clip.png 2>/dev/null || exit) && \
	xclip -selection clipboard -target image/png -i /tmp/scrot-clip.png && \
   	notify-send "Screenshot saved in clipboard" && \
    rm /tmp/scrot-clip.png || \
   	(notify-send -u critical "Something went wrong" ; exit)
