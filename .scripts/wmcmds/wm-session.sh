#!/bin/sh
. $HOME/.dmenurc

shut(){
    sel=$(printf "Yes\\nNo" | dmenu "${DMENU_ARGS[@]}" -p "Are you sure you want to shutdown") || exit 1
    case "$sel" in
        "Yes") shutdown now ;;
        *) exit ;;
    esac
}

reb(){
    sel=$(printf "Yes\\nNo" | dmenu "${DMENU_ARGS[@]}" -p "Are you sure you want to reboot") || exit 1
    case "$sel" in
        "Yes") reboot ;;
        *) exit ;;
    esac
}

lock_screen() {
    sel=$(printf "Yes\\nNo" | dmenu "${DMENU_ARGS[@]}" -p "Are you sure you want to lock the screen") || exit 1
    case "$sel" in
        "Yes") lock-screen ;;
        *) exit ;;
    esac
}

sleep_toram(){
    sel=$(printf "Yes\\nNo" | dmenu "${DMENU_ARGS[@]}" -p "Are you sure you want to sleep") || exit 1
    case "$sel" in
        "Yes") systemctl suspend ;;
        *) exit ;;
    esac
}

exit_i3(){
    sel=$(printf "Yes\\nNo" | dmenu "${DMENU_ARGS[@]}" -p "Are you sure you want to logout") || exit 1
    case "$sel" in
        "Yes") i3-msg exit ;;
        *) exit ;;
    esac
}

selected=$(printf "Shutdown\\nReboot\\nLock screen\\nSleep (RAM)\\nLogout" | dmenu "${DMENU_ARGS[@]}" -p "End session") || exit 1
case "$selected" in
    "Shutdown") shut ;;
    "Reboot") reb ;;
    "Lock screen") lock_screen ;;
    "Sleep (RAM)") sleep_toram ;;
    "Logout") exit_i3 ;;
    *) exit ;;
esac
