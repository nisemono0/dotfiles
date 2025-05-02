#!/bin/bash

# urxvt -geometry 75x20 -name nmtui-instance -e nmtui
alacritty -o 'window.dimensions={columns=75, lines=20}' --class nmtui-instance -e nmtui
