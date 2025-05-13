#!/bin/bash

DUNST_ICON="audio-x-generic-symbolic"

all_added=true
for file in "$@"; do
    file="${file##*/}"
    notify-send -i "$DUNST_ICON" "Adding to mpd" "$file"
    searchlist="$(mpc search filename "$file")"
    if [ -n "$searchlist" ]; then
        while read -r result; do
            if ! mpc add "$result"; then
                notify-send -u critical "Error adding to playlist"
                exit
            fi
        done <<< "$searchlist"
    else
        notify-send -i "$DUNST_ICON" "Couldn't find" "$file"
        all_added=false
    fi
done

if [ "$all_added" = true ]; then
    notify-send -i "$DUNST_ICON" "All files added"
else
    notify-send -i "$DUNST_ICON" "Some files couldn't be added"
fi
