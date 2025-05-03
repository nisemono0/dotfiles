#!/bin/bash

# urxvt -e htop && i3-msg workspace back_and_forth
alacritty --class 'Alacritty,htop-instance' --title 'htop' -e htop && i3-msg workspace back_and_forth
