#!/bin/bash

xrandr -r 144
[[ -f ~/.config/monitor-profiles/BenQ_XL2411_Edited.icc ]] && xcalib -d :0 ~/.config/monitor-profiles/BenQ_XL2411_Edited.icc
