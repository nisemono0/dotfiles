#!/bin/bash

filepath="$1"
filetype=$(file --dereference --mime-type "$filepath" | cut -d ':' -f 2 | tr -d ' ')
spectrogram="/tmp/spectrogram.png"

if [[ "$filetype" == audio/* ]]; then
    sox "$filepath" -n spectrogram -o "$spectrogram"
    nsxiv "$spectrogram"
    rm "$spectrogram"
else
	notify-send "Can only view spectrals of audio files"
fi
