#!/bin/bash

# ibus list-engine
EN_ENGINE="xkb:us::eng"
JP_ENGINE="mozc-jp"


print_input_name() {
    current_input="$(ibus engine)"

    case "$current_input" in
        "$EN_ENGINE") echo "en" ;;
        "$JP_ENGINE") echo "jp" ;;
        *) echo "en" ;;
    esac
}

toggle_input() {
    case "$(ibus engine)" in
        "$EN_ENGINE") ibus engine "$JP_ENGINE" ;;
        "$JP_ENGINE") ibus engine "$EN_ENGINE" ;;
        *) exit ;;
    esac
}

case "$1" in
    --monitor)
        print_input_name

        dbus-monitor --address $(ibus address) --monitor "type='signal',member='GlobalEngineChanged'" 2>/dev/null |
        while read -r; do
            print_input_name
        done

        echo "No IBus"
        ;;
    --toggle)
        toggle_input
        ;;
    *) exit ;;
esac

