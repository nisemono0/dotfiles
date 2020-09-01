#!/usr/bin/bash

scrot -o /tmp/scrot-clip.png 
xclip -selection clipboard -target image/png -i /tmp/scrot-clip.png && notify-send "Screenshot saved in clipboard" || notify-send -u critical "Something went wrong"
rm /tmp/scrot-clip.png
