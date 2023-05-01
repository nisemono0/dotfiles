#!/bin/sh
. $HOME/.dmenurc

shut(){
	sel=$(printf "Yes\\nNo" | dmenu -fn "$DMENU_FN" $DMENU_OPTIONS -p "Are you sure you want to shutdown") || exit 1
	case "$sel" in
		"Yes") shutdown now ;;
		*) exit ;;
	esac
}

reb(){
	sel=$(printf "Yes\\nNo" | dmenu -fn "$DMENU_FN" $DMENU_OPTIONS -p "Are you sure you want to reboot") || exit 1
	case "$sel" in
		"Yes") reboot ;;
		*) exit ;;
	esac
}

sleep_toram(){
	sel=$(printf "Yes\\nNo" | dmenu -fn "$DMENU_FN" $DMENU_OPTIONS -p "Are you sure you want to sleep") || exit 1
	case "$sel" in
		"Yes") reboot ;;
		*) exit ;;
	esac
}

exit_i3(){
	sel=$(printf "Yes\\nNo" | dmenu -fn "$DMENU_FN" $DMENU_OPTIONS -p "Are you sure you want to logout") || exit 1
	case "$sel" in
		"Yes") i3-msg exit ;;
		*) exit ;;
	esac
}

selected=$(printf "Shutdown\\nReboot\\nSleep (RAM)\\nLogout" | dmenu -fn "$DMENU_FN" $DMENU_OPTIONS -p "End session") || exit 1
case "$selected" in
	"Shutdown") shut ;;
	"Reboot") reb ;;
    "Sleep (RAM)") sleep_toram ;;
	"Logout") exit_i3 ;;
	*) exit ;;
esac
