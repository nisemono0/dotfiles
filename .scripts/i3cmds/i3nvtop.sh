#!/bin/bash

# urxvt -e nvtop && i3-msg workspace back_and_forth
alacritty -o 'window.class={instance="nvtop-instance"}' -o 'window.title="nvtop"' -e nvtop && i3-msg workspace back_and_forth
