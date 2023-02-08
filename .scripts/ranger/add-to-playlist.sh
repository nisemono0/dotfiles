#!/bin/bash

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
    fi
done

