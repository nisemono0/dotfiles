#!/bin/bash
. $HOME/.dmenurc

SEEK_STEP=5

play() {
    if mpc "$1"; then
        notify-send -h string:x-dunst-stack-tag:mpdsong "Now playing" "$(mpc current)"
    else
        notify-send -u critical "Couldn't play song"
    fi
}

playsong() {
    songpos=$(mpc playlist -f "%position%.[%artist%|%albumartist%|%file%] - %title%" | \
        dmenu "${DMENU_ARGS_CENTER[@]}" -fn "Noto Sans CJK JP:style=Bold:size=9" -lm -p "Play" | \
        cut -f 1 -d '.')
    [ -z "$songpos" ] && exit
    if mpc play "$songpos"; then
        notify-send -h string:x-dunst-stack-tag:mpdsong "Now playing" "$(mpc current)"
    else
        notify-send -u critical "Couldn't play song"
    fi
}

addsongplay() {
    songfile=$(mpc listall | dmenu "${DMENU_ARGS_CENTER[@]}" -fn "Noto Sans CJK JP:style=Bold:size=9" -lm -p "Add & Play")
    [ -z "$songfile" ] && exit
    if mpc findadd filename "$songfile"; then
        if mpc searchplay filename "$songfile"; then
            notify-send -h string:x-dunst-stack-tag:mpdsong "Now playing" "$(mpc current)"
        else
            notify-send -u critical "Couldn't play song"
        fi
    else
        notify-send -u critical "Couldn't change song"
    fi
}

case "$1" in
    --play-next) play "next" ;; # Plays the next song in the playlist
    --play-prev) play "prev" ;; # Plays the previous song in the playlist
    --seek-forward) mpc seek "+$SEEK_STEP" ;; # Seeks forwards SEEK_STEP seconds
    --seek-backward) mpc seek "-$SEEK_STEP" ;; # Seek backwards SEEK_STEP seconds
    --play-song) playsong ;; # Select song to play from the playlist
    --add-song-play) addsongplay ;; # Select song to add to the playlist and play it
    --toggle-pause) mpc toggle ;; # Pause/Play toggle
    --stop) mpc stop ;; # Stop playback
    *) exit ;;
esac
