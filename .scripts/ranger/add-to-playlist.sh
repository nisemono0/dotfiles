#!/bin/bash

all_added=true
for file in "$@"; do
    searchlist="$(mpc search filename "$file")"
    if [ -n "$searchlist" ]; then
        while read -r result; do
            if ! mpc add "$result"; then
                notify-send -u critical "Error adding to playlist"
                exit
            fi
        done <<< "$searchlist"
    else
        notify-send "Couldn't find" "$file"
        all_added=false
    fi
done

if [ "$all_added" = true ]; then
    notify-send "All files added"
else
    notify-send "Some files couldn't be added"
fi
