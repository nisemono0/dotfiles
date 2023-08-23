#!/bin/sh
. $HOME/.dmenurc

kill_proc(){
    confirm=$(printf "Yes\\nNo" | dmenu "${DMENU_ARGS[@]}" -p "Are you sure") || exit 1
    case "$confirm" in
        "Yes")
            if kill -9 "${1%% *}" 2>/dev/null; then
                notify-send "Process killed successfully" -i dialog-information
            else
                notify-send -u critical "Something went wrong"
                exit 1;
            fi
        ;;
        *) exit ;;
    esac
}

selected_process="$(ps --user "$USER" --format pid,%mem,%cpu,stime,cmd --sort=-%mem,-%cpu --no-header | \
                    dmenu "${DMENU_ARGS[@]}" -l 15 -p "Search for process to kill" | \
                    awk '{print $1}')"


[ -z "$selected_process" ] && exit 1

kill_proc "$selected_process"
