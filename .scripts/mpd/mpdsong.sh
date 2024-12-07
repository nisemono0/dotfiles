#!/bin/bash
. $HOME/.dmenurc

SEEK_STEP=5

play() {
    if mpc "$1"; then
        notify-send -i audio-x-generic-symbolic -h string:x-dunst-stack-tag:mpdsong "Now playing" "$(mpc current)"
    else
        notify-send -u critical "Couldn't play song"
    fi
}

replay_song() {
    if mpc stop && mpc play; then
        notify-send -i audio-x-generic-symbolic -h string:x-dunst-stack-tag:mpdsong "Replaying song" "$(mpc current)"
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
        notify-send -i audio-x-generic-symbolic -h string:x-dunst-stack-tag:mpdsong "Now playing" "$(mpc current)"
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
            notify-send -i audio-x-generic-symbolic -h string:x-dunst-stack-tag:mpdsong "Now playing" "$(mpc current)"
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
            notify-send -h string:x-dunst-stack-tag:mpdsong "Copied to clipboard" "$song"
        else
            notify-send -u critical "Couldn't copy to clipboard"
        fi
    fi
}

case "$1" in
    --play-next) play "next" ;; # Plays the next song in the playlist
    --play-prev) play "prev" ;; # Plays the previous song in the playlist
    --seek-forward) mpc seek "+$SEEK_STEP" ;; # Seeks forwards SEEK_STEP seconds
    --seek-backward) mpc seek "-$SEEK_STEP" ;; # Seek backwards SEEK_STEP seconds
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
