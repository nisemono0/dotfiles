#!/bin/bash

file="$1"

if [[ "$file" == *.png ]]; then
	xclip -selection clipboard -target image/png -i "$file" && notify-send "Image copied to clipboard" || notify-send -u critical "Something went wrong"
else
	convert "$file" png:- | xclip -selection clipboard -target image/png -i && notify-send "Image copied to clipboard" || notify-send -u critical "Something went wrong"
fi
