#!/bin/bash

# urxvt -e htop && i3-msg workspace back_and_forth
alacritty -o 'window.class={instance="htop-instance"}' -o 'window.title="htop"' -e htop && i3-msg workspace back_and_forth
