#!/bin/bash

[ $# -ne 1 ] && echo "Too few/many arguments, expecting 1" && exit 1

save_screenshot() {
    scr_dir="${HOME}/Pictures/Screenshot"
    mkdir -p "$scr_dir" || { notify-send -u critical "Couldn't create screenshot directory"; exit; }

    printf -v date "%(%F)T"
    printf -v time "%(%I-%M-%S)T"

    mkdir -p "${scr_dir}/${date}"
    scr="${scr_dir}/${date}/${date}-${time}.png"

    case "$1" in
        full)
            if maim --hidecursor --capturebackground "$scr"; then
                notify-send "Saved screenshot as ${scr/*\/}" -i "${scr}"
            fi
            ;;
        area)
            if maim --hidecursor --capturebackground --select --bordersize 2 "$scr" 2>/dev/null; then
                notify-send "Saved screenshot as ${scr/*\/}" -i "${scr}"
            fi
            ;;
        *)
            exit 1
            ;;
    esac
}

save_clipboard() {
    scr="/tmp/screenshot-clipboard.png"

    case "$1" in
        full)
            if maim --hidecursor --capturebackground "$scr" 2>/dev/null; then
                xclip -selection clipboard -target image/png -i "$scr" && \
                notify-send "Screenshot saved in clipboard" -i "$scr" && \
                rm "$scr"
            fi
            ;;
        area)
            if maim --hidecursor --capturebackground --select --bordersize 2 "$scr" 2>/dev/null; then
	            xclip -selection clipboard -target image/png -i "$scr" && \
	            notify-send "Screenshot saved in clipboard" -i "$scr" && \
	            rm "$scr"
            fi
            ;;
        *)
            exit 1
            ;;
    esac
}

case "$1" in
    --save-full)
        save_screenshot full
        ;;
    --save-area)
        save_screenshot area
        ;;
    --clip-full)
        save_clipboard full
        ;;
    --clip-area)
        save_clipboard area
        ;;
    *)
        echo "$0 <--save-full | --save-area | --clip-full | --clip-area>"
        exit 1
        ;;
esac
