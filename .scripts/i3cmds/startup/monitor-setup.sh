#!/bin/bash

xrandr -r 144
[[ -f ~/.config/monitor-profile.icc ]] && xcalib -d :0 ~/.config/monitor-profile.icc
