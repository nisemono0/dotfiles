#!/bin/bash

# Whack way to get default dmenu args
# . $HOME/.dmenurc
# echo "${DMENU_ARGS[@]}"

i3-dmenu-desktop --dmenu='dmenu -b -i -nf "#8f525d" -nb "#0a0f18" -sf "#c1c3c5" -sb "#6c4853" -fn "SauceCodePro Nerd Font:style=Bold:size=10" -p "Open"'

