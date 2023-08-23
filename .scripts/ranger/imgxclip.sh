#!/bin/bash

filepath="$1"
filetype=$(file -b --dereference --mime-type "$filepath" | tr -d ' ')

if [[ "$filetype" == image/* ]]; then
    if [[ "$filetype" == image/png ]]; then
        xclip -selection clipboard -target image/png -i "$filepath" &> /dev/null && notify-send "Image copied to clipboard" -i "$filepath" || notify-send -u critical "Something went wrong"
    else
        convert "$filepath" png:- | xclip -selection clipboard -target image/png -i &> /dev/null && notify-send "Image copied to clipboard" -i "$filepath" || notify-send -u critical "Something went wrong"
    fi
else
    notify-send "Can only copy images into clipboard"
fi
