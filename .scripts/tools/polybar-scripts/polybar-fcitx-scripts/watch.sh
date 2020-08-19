#!/bin/bash

# From duongdominhchau
# https://aur.archlinux.org/packages/polybar-fcitx-scripts/ 
# Just edited a bit

##
# Watch for events from Fcitx.
#
# Because this script won't stop, I have to put the event handling part
# in another file named `react`.
##

REACT_PATH="$HOME/.scripts/tools/polybar-scripts/polybar-fcitx-scripts/react.sh"

# Need --line-buffered to avoid messages being hold in buffer
gdbus monitor --session --dest org.fcitx.Fcitx --object-path /inputmethod | grep --line-buffered / | "$REACT_PATH"
