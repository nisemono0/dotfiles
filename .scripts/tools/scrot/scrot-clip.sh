#!/usr/bin/bash

scrot /tmp/scrot-clip.png 
xclip /tmp/scrot-clip.png -selection clipboard -target image/png -i
rm /tmp/scrot-clip.png
notify-send "Screenshot saved in clipboard"
