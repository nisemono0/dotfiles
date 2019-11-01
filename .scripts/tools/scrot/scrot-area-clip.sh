#!/usr/bin/bash
sleep 0.2 ; scrot -s -f /tmp/scrot-clip.png
xclip /tmp/scrot-clip.png -selection clipboard -target image/png -i
rm /tmp/scrot-clip.png
notify-send "Saved screenshot in clipboard"
