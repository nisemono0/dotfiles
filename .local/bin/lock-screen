#!/bin/sh

FG="$(xrdb -query | grep -w "*foreground" | cut -f 2)"
BG="$(xrdb -query | grep -w "*background" | cut -f 2)D0"
COLOR1="$(xrdb -query | grep -w "*color1" | cut -f 2)"
COLOR2="$(xrdb -query | grep -w "*color2" | cut -f 2)D0"
COLOR4="$(xrdb -query | grep -w "*color4" | cut -f 2)"
COLOR10="$(xrdb -query | grep -w "*color10" | cut -f 2)"
COLOR11="$(xrdb -query | grep -w "*color11" | cut -f 2)"

DATE_FORMAT="%a, %b %d"
TIME_FORMAT="%I:%M:%S"

FONT="monospace"

BLUR_SIGMA=3

i3lock \
--ignore-empty-password \
--pass-media-keys \
--pass-screen-keys \
--pass-volume-keys \
--pass-power-keys \
--indicator \
--nofork \
--clock \
--radius=120 \
--ring-width=14 \
--time-size=38 \
--time-str="$TIME_FORMAT" \
--date-size=18 \
--date-str="$DATE_FORMAT" \
--time-font="$FONT" \
--date-font="$FONT" \
--no-modkey-text \
--greeter-text="" \
--noinput-text="" \
--verif-text="" \
--wrong-text="" \
--lock-text="" \
--lockfailed-text="" \
--line-uses-ring \
--time-color="$FG" \
--date-color="$FG" \
--insidewrong-color="$BG" \
--insidever-color="$BG" \
--inside-color="$BG" \
--ringwrong-color="$COLOR1" \
--ringver-color="$COLOR4" \
--ring-color="$COLOR2" \
--separator-color="$FG" \
--keyhl-color="$COLOR10" \
--bshl-color="$COLOR11" \
--blur=$BLUR_SIGMA
