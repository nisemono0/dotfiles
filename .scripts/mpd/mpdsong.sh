#!/bin/bash
. $HOME/.dmenurc

SEEK_STEP=5
DUNST_ICON="audio-x-generic-symbolic"
FALLBACK_ICON="audio-x-generic-symbolic"
TMP_IMG="/tmp/mpd_dunst.jpg"
MUSIC_LIB="$HOME/Music"

find_cover_image() {
    # First we check if the audio file has an embedded album art
    ext="$(mpc --format %file% current | sed 's/^.*\.//')"
    if [ "$ext" = "flac" ]; then
        # since FFMPEG cannot export embedded FLAC art we use metaflac
        metaflac --export-picture-to="$TMP_IMG" \
            "$(mpc --format "$MUSIC_LIB"/%file% current)" &&
            DUNST_ICON="$TMP_IMG" && return
    else
        ffmpeg -y -i "$(mpc --format "$MUSIC_LIB"/%file% | head -n 1)" \
            "$TMP_IMG" &&
            DUNST_ICON="$TMP_IMG" && return
    fi

    # If no embedded art was found we look inside the music file's directory
    album="$(mpc --format %album% current)"
    file="$(mpc --format %file% current)"
    album_dir="${file%/*}"
    album_dir="$MUSIC_LIB/$album_dir"
    found_covers="$(find "$album_dir" -type d -exec find {} -maxdepth 1 -type f \
    -iregex ".*/.*\(${album}\|cover\|folder\|artwork\|front\).*[.]\\(jpe?g\|png\|gif\|bmp\)" \; )"
    DUNST_ICON="$(echo "$found_covers" | head -n1)"
    if [ -n "$DUNST_ICON" ]; then
        return
    fi

    # If we still failed to find a cover image, we use the fallback
    if [ -z "$DUNST_ICON" ]; then
        DUNST_ICON="$FALLBACK_ICON"
    fi
}

play() {
    if mpc "$1"; then
        find_cover_image
        notify-send -i "$DUNST_ICON" -h string:x-dunst-stack-tag:mpdsong "Now playing" "$(mpc current)"
    else
        notify-send -u critical "Couldn't play song"
    fi
}

seek() {
    if mpc seek "$1"; then
        current_song=$(mpc current)
        song_time=$(mpc status '%currenttime%/%totaltime%')
        seek_percent=$(mpc status '%percenttime%')
        seek_percent="${seek_percent//[^0-9]/}"
        notify-send -i "$DUNST_ICON" -h string:x-dunst-stack-tag:mpdsongseek -h int:value:"$seek_percent" "$current_song" "$song_time"
    else
        notify-send -u critical "Couldn't seek"
    fi
}

replay_song() {
    if mpc stop && mpc play; then
        find_cover_image
        notify-send -i "$DUNST_ICON" -h string:x-dunst-stack-tag:mpdsong "Replaying song" "$(mpc current)"
    else
        notify-send -u critical "Couldn't play song"
    fi
}

playsong() {
    [ "$1" = "mp" ] && DMENU_ARGS_CENTER+=("-mp")

    currentsongpos=$(mpc current -f "%position%")
    if [ -z "$currentsongpos" ]; then
        currentsongpos=0
    else
        currentsongpos=$((currentsongpos - 1))
    fi
    songpos=$(mpc playlist -f "%position%.[%artist%|%albumartist%|%file%] - %title%" | \
        dmenu "${DMENU_ARGS_CENTER[@]}" -fn "Noto Sans CJK JP:style=Bold:size=9" -n "$currentsongpos" -lm -p "Play" | \
        cut -f 1 -d '.')
    [ -z "$songpos" ] && exit

    if mpc play "$songpos"; then
        find_cover_image
        notify-send -i "$DUNST_ICON" -h string:x-dunst-stack-tag:mpdsong "Now playing" "$(mpc current)"
    else
        notify-send -u critical "Couldn't play song"
    fi
}

addsongplay() {
    [ "$1" = "mp" ] && DMENU_ARGS_CENTER+=("-mp")

    songfile=$(mpc listall | dmenu "${DMENU_ARGS_CENTER[@]}" -fn "Noto Sans CJK JP:style=Bold:size=9" -lm -p "Add & Play")
    [ -z "$songfile" ] && exit

    if mpc findadd filename "$songfile"; then
        if mpc searchplay filename "$songfile"; then
            find_cover_image
            notify-send -i "$DUNST_ICON" -h string:x-dunst-stack-tag:mpdsong "Now playing" "$(mpc current)"
        else
            notify-send -u critical "Couldn't play song"
        fi
    else
        notify-send -u critical "Couldn't change song"
    fi
}

copy_playing() {
    song="$(mpc current)"
    if [ -n "$song" ]; then
        if xclip -selection clipboard <<< "$song"; then
            notify-send -h string:x-dunst-stack-tag:mpdsongcopy "Copied to clipboard" "$song"
        else
            notify-send -u critical "Couldn't copy to clipboard"
        fi
    fi
}

case "$1" in
    --play-next) play "next" ;; # Plays the next song in the playlist
    --play-prev) play "prev" ;; # Plays the previous song in the playlist
    --seek-forward) seek "+$SEEK_STEP" ;; # Seeks forwards SEEK_STEP seconds
    --seek-backward) seek "-$SEEK_STEP" ;; # Seek backwards SEEK_STEP seconds
    --play-song) playsong ;; # Select song to play from the playlist
    --play-song-mp) playsong "mp" ;; # Same as above but moves the pointer to dmenu window
    --add-song-play) addsongplay ;; # Select song to add to the playlist and play it
    --add-song-play-mp) addsongplay "mp" ;; # Same as above but moves the pointer to dmenu window
    --toggle-pause) mpc toggle ;; # Pause/Play toggle
    --stop) mpc stop ;; # Stop playback
    --replay-song) replay_song ;;
    --copy-playing) copy_playing ;;
    *) exit ;;
esac
