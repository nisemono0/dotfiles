#!/bin/bash

if [ "$#" -ne 2 ]; then
    notify-send -u critical "You need to select 2 files"
    exit 1
fi

first_file="$1"
second_file="$2"
first_filetype=$(file --dereference --mime-type "$first_file" | cut -d ':' -f 2 | tr -d ' ')
second_filetype=$(file --dereference --mime-type "$second_file" | cut -d ':' -f 2 | tr -d ' ')

if [[ "$first_filetype" == audio/* ]] && [[ "$second_filetype" == audio/* ]]; then
    spectrogram_diff="$(mktemp)"
    sox -m -v 1 "$first_file" -v -1 "$second_file" -n spectrogram -c "Difference" -o "$spectrogram_diff"
    nsxiv -p "$spectrogram_diff"
    rm -- "$spectrogram_diff"
fi
