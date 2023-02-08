#!/bin/bash

archive="$1"
tmpdir="$(mktemp -d)"
filename="$(basename "$archive")"

notify-send "Extracting..." "$filename" -i "package-x-generic"

if aunpack -X "$tmpdir" "$archive"; then
    find "$tmpdir" -type f | sort -V | nsxiv -i
else
    notify-send -u critical "Error at extracting" "$archive"
fi

rm -r -- "$tmpdir"
