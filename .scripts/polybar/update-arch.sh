#!/bin/sh

TERM_CMD="/usr/bin/urxvt -geometry 100x25 -name notification-updates-arch -e sh -c"

total_updates() {
    if ! main_updates=$(checkupdates 2> /dev/null | wc -l ); then
        main_updates=0
    fi

    if ! aur_updates=$(yay -Qum 2> /dev/null | wc -l); then
        aur_updates=0
    fi

    total_updates=$((main_updates + aur_updates))

    if [ "$total_updates" -gt 0 ]; then
        echo "# $main_updates:$aur_updates"
    else
        echo ""
    fi
}

detail_updates() {
    echo "=====[Official]====="
    if ! checkupdates; then
        echo "No official updates"
    fi
    echo "=====[AUR]====="
    if ! yay -Qum 2> /dev/null; then
        echo "No AUR updates"
    fi

    printf "\n"
    echo "=========="
    echo "Update now ? (y[es]/n[o]/a[ll]/q[uit])"
    read -rsn 1 ans
    ans=$(echo "$ans" | tr '[:upper:]' '[:lower:]')
    case "$ans" in
        q|n|Q|N) exit ;;
        y|Y|"")
            sudo pacman -Syu
            read -rsn 1
            ;;
        a|A)
            yay -Syu
            read -rsn 1
            ;;
        *) exit ;;
    esac
}

notify_updates() {
    notify-send -h string:x-dunst-stack-tag:sysupdates "System updates" "Checking for updates..."

    notify_text=""
    official_updates="$(checkupdates --nocolor)"
    aur_updates="$(yay -Qum)"

    if [ -n "$official_updates" ]; then
        notify_text="${notify_text}===[Official]==="$'\n'"${official_updates}"$'\n'
    else
        notify_text="${notify_text}===[Official]==="$'\n'"No official updates"$'\n'
    fi

    if [ -n "$aur_updates" ]; then
        notify_text="${notify_text}===[AUR]==="$'\n'"${aur_updates}"$'\n'
    else
        notify_text="${notify_text}===[AUR]==="$'\n'"No AUR updates"$'\n'
    fi

    notif_action=$(notify-send -t 0 -h string:x-dunst-stack-tag:sysupdates \
        -A "Main=Update official" -A "AUR=Update AUR" -A "All=Update all" \
        "System updates" "${notify_text}")

    case "$notif_action" in
        "Main" )
            $TERM_CMD "sudo pacman -Syu ; echo 'Press any key to exit' ; read -rsn 1"
            ;;
        "AUR")
            $TERM_CMD "yay -Sua ; echo 'Press any key to exit' ; read -rsn 1"
            ;;
        "All")
            $TERM_CMD "yay -Syu ; echo 'Press any key to exit' ; read -rsn 1"
            ;;
        *) exit ;;
    esac
}

case "$1" in
    --total)
        total_updates
        ;;
    --detail)
        detail_updates
        ;;
    --notify)
        notify_updates
        ;;
    *)
        exit 1
        ;;
esac
