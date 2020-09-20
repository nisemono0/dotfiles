#!/bin/sh
. $HOME/.dmenurc

shut(){
	sel=$(printf "Yes\\nNo" | dmenu -fn "$DMENU_FN" $DMENU_OPTIONS -i -p "Are you sure you want to shutdown ?") || exit 1
	case "$sel" in
		"Yes") shutdown now ;;
		*) exit ;;
	esac
}

reb(){
	sel=$(printf "Yes\\nNo" | dmenu -fn "$DMENU_FN" $DMENU_OPTIONS -i -p "Are you sure you want to reboot ?") || exit 1
	case "$sel" in
		"Yes") reboot ;;
		*) exit ;;
	esac
}

exit_i3(){
	sel=$(printf "Yes\\nNo" | dmenu -fn "$DMENU_FN" $DMENU_OPTIONS -i -p "Are you sure you want to exit i3 ?") || exit 1
	case "$sel" in
		"Yes") i3-msg exit ;;
		*) exit ;;
	esac
}

selected=$(printf "Shutdown\\nReboot\\nExit i3" | dmenu -fn "$DMENU_FN" $DMENU_OPTIONS -i -p "End session") || exit 1
case "$selected" in
	"Shutdown") shut ;;
	"Reboot") reb ;;
	"Exit i3") exit_i3 ;;
	*) exit ;;
esac
