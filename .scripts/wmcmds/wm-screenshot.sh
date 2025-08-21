#!/bin/bash
. $HOME/.dmenurc

FREEZE_SCR=""

[ $# -gt 2 ] && echo "Too few/many arguments, expecting at least 1" && exit 1

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
            if [ "$FREEZE_SCR" = "true" ]; then
                if scrot -s -f -l mode=classic,width=2,color=white "$scr"; then
                    notify-send "Saved screenshot as ${scr/*\/}" -i "${scr}"
                fi
            else
                if scrot -s -l mode=edge,width=2,color=white "$scr"; then
                    notify-send "Saved screenshot as ${scr/*\/}" -i "${scr}"
                fi
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
            if [ "$FREEZE_SCR" = "true" ]; then
                if scrot -s -f -l mode=classic,width=2,color=white --overwrite --format png "$scr"; then
                    xclip -selection clipboard -target image/png -i "$scr" &> /dev/null && \
                    notify-send "Screenshot saved in clipboard" -i "$scr" && \
                    rm -- "$scr"
                fi
            else
                if scrot -s -l mode=edge,width=2,color=white --overwrite --format png "$scr"; then
                    xclip -selection clipboard -target image/png -i "$scr" &> /dev/null && \
                    notify-send "Screenshot saved in clipboard" -i "$scr" && \
                    rm -- "$scr"
                fi
            fi
            ;;
        *)
            exit 1
            ;;
    esac
}

screenshot_menu() {
    #sleep here is a hacky way to wait until dmenu disappears before scrot freezes the screen
    case $(printf "Save full\\nSave area\\nSave area freeze\\nClipboard full\\nClipboard area\\nClipboard area freeze" | dmenu "${DMENU_ARGS_CENTER[@]}" -p "Screenshot" && sleep 0.25) in
        "Save full")
            save_screenshot full
            ;;
        "Save area")
            save_screenshot area
            ;;
        "Save area freeze")
            FREEZE_SCR="true"
            save_screenshot area
            ;;
        "Clipboard full")
            save_clipboard full
            ;;
        "Clipboard area")
            save_clipboard area
            ;;
        "Clipboard area freeze")
            FREEZE_SCR="true"
            save_clipboard area
            ;;
        *) exit ;;
    esac
}

case "$2" in
    --freeze)
        FREEZE_SCR="true"
        ;;
    *)
        FREEZE_SCR="false"
        ;;
esac

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
    --menu)
        screenshot_menu
        ;;
    *)
        echo "$0 <--save-full | --save-area | --clip-full | --clip-area> [--freeze]"
        exit 1
        ;;
esac
