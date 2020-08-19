#!/bin/bash

##
# Print out identifier of current input method
##

gdbus call --session --dest org.fcitx.Fcitx \
    --object-path /inputmethod \
    --method org.fcitx.Fcitx.InputMethod.GetCurrentIM |
    grep -Po "'([^']++)'" | sed -Ee "s/'([^']++)'/\\1/g"
