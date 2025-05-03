#!/bin/bash

# urxvt -e nvtop && i3-msg workspace back_and_forth
alacritty --class 'Alacritty,nvtop-instance' --title 'nvtop' -e nvtop && i3-msg workspace back_and_forth
