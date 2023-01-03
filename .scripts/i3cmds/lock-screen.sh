#!/usr/bin/bash -e

TMPBG=/tmp/screen_locked.jpg
maim --hidecursor --capturebackground $TMPBG

# Pixellate 10x
mogrify -scale 10% -scale 1000% $TMPBG

DATE=$(date +"%A, %B %-d")

color1="$(xrdb -query | grep -w "*color2" | cut -f 2)"  # NF
color2="$(xrdb -query | grep -w "*color4" | cut -f 2)"  # NB
color3="$(xrdb -query | grep -w "*color7" | cut -f 2)"  # SF
color4="$(xrdb -query | grep -w "*color1" | cut -f 2)"  # SB

ringcolor=$color3
insidecolor=00000000
linecolor=00000000
separatorcolor=00000000

ringvercolor=00000000
insidevercolor=00000000

ringwrongcolor=00000000
insidewrongcolor=00000000

keyhlcolor=$color2
bshlcolor=$color2

verifcolor=$color3
wrongcolor=$color4
greetercolor=$color3

timecolor=$color3
datecolor=$color1

layoutcolor=$color4

i3lock --image=$TMPBG  \
    --pass-media-keys --keylayout 0 --layout-color=$layoutcolor \
    --clock --force-clock --time-pos="w/2:h/2" --time-size=96 --time-color=$timecolor \
    --date-str="$DATE" --date-pos="tx:ty+80" --date-size=32 --date-color=$datecolor \
    --ind-pos="w/2-r/2:h-r*2" --radius 20 \
    --ring-color=$ringcolor --inside-color=$insidecolor --line-color=$linecolor \
    --separator-color=$separatorcolor --ringver-color=$ringvercolor \
    --insidever-color=$insidevercolor --verif-text='Verifying password' --verif-color=$verifcolor --ringwrong-color=$ringwrongcolor \
    --insidewrong-color=$insidewrongcolor --wrong-text='Wrong password' --wrong-color=$wrongcolor --keyhl-color=$keyhlcolor \
    --bshl-color=$bshlcolor --noinput-text='' --greeter-text="Screen locked" --greeter-color=$greetercolor

rm $TMPBG
