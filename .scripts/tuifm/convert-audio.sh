#!/bin/bash

DUNST_ICON="audio-x-generic-symbolic"

convert_to_flac() {
    file="$1"
    new_file="${file%.*}.flac"
    if ffmpeg -v 8 -i "$file" -map_metadata 0 -compression_level 12 "$new_file"; then
        notify-send -i "$DUNST_ICON" "Finished converting" "$new_file"
    else
        notify-send -u critical "Couldn't convert" "$file"
    fi
}

convert_to_mp3() {
    file="$1"
    new_file="${file%.*}.mp3"
    bitrate="$2"
    if ffmpeg -v 8 -i "$file" -map_metadata 0 -b:a "$bitrate" "$new_file"; then
        notify-send -i "$DUNST_ICON" "Finished converting" "$new_file"
    else
        notify-send -u critical "Couldn't convert" "$file"
    fi
}

convert_to_aac() {
    file="$1"
    new_file="${file%.*}.aac"
    bitrate="$2"
    if ffmpeg -v 8 -i "$file" -map_metadata 0 -b:a "$bitrate" "$new_file"; then
        notify-send -i "$DUNST_ICON" "Finished converting" "$new_file"
    else
        notify-send -u critical "Couldn't convert" "$file"
    fi
}

print_help() {
    echo "./$0 <flac | aac-128 | mp3-{192,256,320}> <audio_files>"
}

arg="$1"
shift 1
if [ "$#" -eq 0 ]; then
    notify-send -u critical "No audio files given"
    print_help
    exit 1
fi

export -f convert_to_flac
export -f convert_to_mp3
export -f convert_to_aac

case "$arg" in
    flac)
        notify-send -i "$DUNST_ICON" "Started converting" "flac"
        parallel --eta convert_to_flac {} ::: "$@"
        notify-send -i "$DUNST_ICON" "Finished converting all files to flac"
        ;;
    mp3-192)
        notify-send -i "$DUNST_ICON" "Started converting" "mp3 192k"
        parallel --eta convert_to_mp3 {} "192k" ::: "$@"
        notify-send -i "$DUNST_ICON" "Finished converting all files to mp3 192k"
        ;;
    mp3-256)
        notify-send -i "$DUNST_ICON" "Started converting" "mp3 256k"
        parallel --eta convert_to_mp3 {} "256k" ::: "$@"
        notify-send -i "$DUNST_ICON" "Finished converting all files to mp3 256k"
        ;;
    mp3-320)
        notify-send -i "$DUNST_ICON" "Started converting" "mp3 320k"
        parallel --eta convert_to_mp3 {} "320k" ::: "$@"
        notify-send -i "$DUNST_ICON" "Finished converting all files to mp3 320k"
        ;;
    aac-128)
        notify-send -i "$DUNST_ICON" "Started converting" "aac 128k"
        parallel --eta convert_to_aac {} "128k" ::: "$@"
        notify-send -i "$DUNST_ICON" "Finished converting all files to aac 128k"
        ;;
    *)
        print_help
        exit 0
        ;;
esac
