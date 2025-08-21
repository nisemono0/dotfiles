#!/bin/bash

# urxvt -geometry 100x20 -name pulsemixer-instance -e pulsemixer --color 1
alacritty -o 'window.dimensions={columns=100, lines=20}' --class 'Alacritty,pulsemixer-instance' --title 'pulsemixer' -e pulsemixer --color 1
