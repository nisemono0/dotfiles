#!/bin/bash

DUNST_ICON="package-x-generic"

archive="$1"
tmpdir="$(mktemp -d)"
filename="$(basename "$archive")"
file_extension="${filename##*.}"
file_extension="$(printf "%s" "${file_extension}" | tr '[:upper:]' '[:lower:]')"

notify-send -i "$DUNST_ICON" -h string:x-dunst-stack-tag:extractview "Extracting..." "$filename"

view_extracted() {
    find "$tmpdir" -type f | sort -V | nsxiv -i -p -a
}

extract_progress_bar() {
    current_file=1
    total_files="$1"
    notif_bar_max=100
    while IFS= read -r file; do
        progress=$(( (notif_bar_max*current_file)/total_files ))
        ((current_file++))
        notify-send -i "$DUNST_ICON" -h int:value:"$progress" -h string:x-dunst-stack-tag:extractview "Extracting..." "$filename"
    done < <(aunpack -X "$tmpdir" "$archive")
    view_extracted
}

extract_normal() {
    if aunpack -X "$tmpdir" "$archive"; then
        view_extracted
    else
        notify-send -u critical "Error at extracting" "$archive"
    fi
}

case "${file_extension}" in
    zip) extract_progress_bar $(zipinfo -1 "$archive" | wc -l) ;;
    bz|bz2|gz|tar) extract_progress_bar $(tar --list --file "$1" | wc -l) ;;
    *) extract_normal ;;
esac

rm -r -- "$tmpdir"
