#!/bin/bash

# urxvt -e htop && i3-msg workspace back_and_forth

case "$1" in
    --tile) alacritty --class 'Alacritty,htop-instance-tile' --title 'htop' -e htop && i3-msg workspace back_and_forth ;;
    --float) alacritty -o 'window.dimensions={columns=150, lines=40}' --class 'Alacritty,htop-instance-float' --title 'htop' -e htop ;;
    *) exit 1 ;;
esac
