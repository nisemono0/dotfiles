#!/bin/bash

# urxvt -e nvtop && i3-msg workspace back_and_forth

case "$1" in
    --tile) alacritty --class 'Alacritty,nvtop-instance-tile' --title 'nvtop' -e nvtop && i3-msg workspace back_and_forth ;;
    --float) alacritty -o 'window.dimensions={columns=150, lines=40}' --class 'Alacritty,nvtop-instance-float' --title 'nvtop' -e nvtop ;;
    *) exit 1 ;;
esac
