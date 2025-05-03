#!/bin/bash

copy_to_clipboard() {
    [ -z "$1" ] && exit

    if xclip -selection clipboard <<< "$1"; then
        notify-send -h string:x-dunst-stack-tag:ipaddr "Copied ip address" "$1"
    else
        notify-send -u critical "Couldn't copy to clipboard"
    fi
}

get_local_addr() {
    IFS=$' ' read -r -d '' -a local_addr < <( hostname -i && printf '\0' )

    if [ -z "${local_addr[@]}" ]; then
        notify-send -h string:x-dunst-stack-tag:ipaddr "No local address"
        exit
    fi

    notif_actions=()
    for addr in "${local_addr[@]}"; do
        notif_actions+=(-A "$addr=Copy")
    done

    OLD_IFS="$IFS"
    IFS=$'\n'
    ip_addr="$(notify-send -t 0 -h string:x-dunst-stack-tag:ipaddr "${notif_actions[@]}" "Local address" "${local_addr[*]}")"
    IFS="$OLD_IFS"

    copy_to_clipboard "$ip_addr"
}

get_wan_addr() {
    URL="ifconfig.co"

    wan_4=$(curl -fsS -4 "$URL")
    wan_6=$(curl -fsS -6 "$URL")

    if [ -z "$wan_4" ] || [ -z "$wan_6" ]; then
        notify-send -h string:x-dunst-stack-tag:ipaddr "No WAN address"
        exit
    fi

    notif_actions=(-A "$wan_4=Copy" -A "$wan_6=Copy")

    ip_addr="$(notify-send -t 0 -h string:x-dunst-stack-tag:ipaddr "${notif_actions[@]}" "WAN address" "$wan_4\n$wan_6")"

    copy_to_clipboard "$ip_addr"
}

case "$1" in
    --local) get_local_addr ;;
    --wan) get_wan_addr ;;
    *) exit 1 ;;
esac
