#!/bin/bash

DUNST_ICON="audio-x-generic-symbolic"

filepath="$1"
filetype=$(file --dereference --mime-type "$filepath" | cut -d ':' -f 2 | tr -d ' ')

if [[ "$filetype" == audio/* ]]; then
    spectrogram="$(mktemp)"
    sox "$filepath" -n spectrogram -c "Single" -o "$spectrogram"
    nsxiv -p "$spectrogram"
    rm -- "$spectrogram"
else
    notify-send -i "$DUNST_ICON" "Can only view spectrals of audio files"
fi
