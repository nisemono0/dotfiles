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
            if scrot --format png "$scr"; then
                notify-send "Saved screenshot as ${scr/*\/}" -i "${scr}"
            fi
            ;;
        area)
            if scrot -s -f -l mode=classic,width=2,color=white "$scr"; then
                notify-send "Saved screenshot as ${scr/*\/}" -i "${scr}"
            fi
            ;;
        *)
            exit 1
            ;;
    esac
}

save_clipboard() {
    scr="$(mktemp)"

    case "$1" in
        full)
            if scrot --overwrite --format png "$scr"; then
                xclip -selection clipboard -target image/png -i "$scr" &> /dev/null && \
                notify-send "Screenshot saved in clipboard" -i "$scr" && \
                rm -- "$scr"
            fi
            ;;
        area)
            if scrot -s -f -l mode=classic,width=2,color=white --overwrite --format png "$scr"; then
                xclip -selection clipboard -target image/png -i "$scr" &> /dev/null && \
                notify-send "Screenshot saved in clipboard" -i "$scr" && \
                rm -- "$scr"
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
