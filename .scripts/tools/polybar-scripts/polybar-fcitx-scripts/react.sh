#!/bin/bash

##
# This script wait for events from `watch` and
# update the text by printing a new line.
##

IMLIST_PATH="$HOME/.scripts/tools/polybar-scripts/polybar-fcitx-scripts/imlist.sh"
CURRENT_PATH="$HOME/.scripts/tools/polybar-scripts/polybar-fcitx-scripts/current.sh"

# Strip `Keyboard - ` part from IM name then print
print_pretty_name() {
    "$IMLIST_PATH" | sed -Ee 's/^Keyboard - //g' | grep "$("$CURRENT_PATH")" | cut -d',' -f3
}

# Without this, Polybar will display empty
# string until you switch input method.
print_pretty_name

# Track input method changes. Each new line read is an event fired from IM switch
while true
do
    read -r unused
    print_pretty_name
done
