#!/bin/bash

# urxvt -geometry 75x15 -name ncmpcpp-instance -e ncmpcpp-ueberzug
alacritty -o 'window.dimensions={columns=75, lines=15}' -o 'window.class={instance="ncmpcpp-instance"}' -e ncmpcpp-ueberzug
