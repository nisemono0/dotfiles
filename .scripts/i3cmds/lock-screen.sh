#!/usr/bin/bash -e

TMPBG=/tmp/screen_locked.jpg
scrot -q 80 $TMPBG

mogrify -scale 20% -blur 0x1.5 -resize 500% $TMPBG

DATE=$(date +"%A, %B %-d")

color1="$(xrdb -query | grep -w "*color2" | cut -f 2)"
color2="$(xrdb -query | grep -w "*color4" | cut -f 2)"
color3="$(xrdb -query | grep -w "*color7" | cut -f 2)"
color4="$(xrdb -query | grep -w "*color1" | cut -f 2)"

outcolor="$(xrdb -query | grep -w "*background" | cut -f 2)"
outlayoutw="0.2"
outtimew="1"
outdatew="0.4"
outverifw="0.3"
outwrongw="0.2"
outgreeterw="0.3"

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
    --pass-media-keys --keylayout 0 --layout-color=$layoutcolor --layoutoutline-color=$outcolor --layoutoutline-width=$outlayoutw \
    --clock --force-clock --time-pos="w/2:h/2" --time-size=96 --time-color=$timecolor --timeoutline-color=$outcolor --timeoutline-width=$outtimew \
    --date-str="$DATE" --date-pos="tx:ty+80" --date-size=32 --date-color=$datecolor --dateoutline-color=$outcolor --dateoutline-width=$outdatew \
    --ind-pos="w/2-r/2:h-r*2" --radius 25 \
    --ring-color=$ringcolor --inside-color=$insidecolor --line-color=$linecolor \
    --separator-color=$separatorcolor --ringver-color=$ringvercolor \
    --insidever-color=$insidevercolor --verif-text='Verifying password' --verif-color=$verifcolor --verifoutline-color=$outcolor --verifoutline-width=$outverifw --ringwrong-color=$ringwrongcolor \
    --insidewrong-color=$insidewrongcolor --wrong-text='Wrong password' --wrong-color=$wrongcolor --wrongoutline-color=$outcolor --wrongoutline-width=$outwrongw --keyhl-color=$keyhlcolor \
    --bshl-color=$bshlcolor --noinput-text="" --greeter-text="" --greeter-color=$greetercolor --greeteroutline-color=$outcolor --greeteroutline-width=$outgreeterw

rm $TMPBG
