#!/bin/bash

filepath="$1"
filetype=$(file --dereference --mime-type "$filepath" | cut -d ':' -f 2 | tr -d ' ')

if [[ "$filetype" == audio/* ]]; then
    spectrogram="$(mktemp)"
    sox "$filepath" -n spectrogram -c "Single" -o "$spectrogram"
    nsxiv -p "$spectrogram"
    rm -- "$spectrogram"
else
    notify-send "Can only view spectrals of audio files"
fi
