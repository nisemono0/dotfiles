#!/usr/bin/bash -e

TMPBG=/tmp/screen_locked.png
scrot $TMPBG

# Pixellate 10x
mogrify -scale 10% -scale 1000% $TMPBG

DATE=$(date +"%A, %B %-d")

ringcolor=FFFFFFFF
insidecolor=00000000
linecolor=00000000
separatorcolor=00000000

ringvercolor=00000000
insidevercolor=00000000

ringwrongcolor=00000000
insidewrongcolor=00000000

keyhlcolor=AAAAAAFF
bshlcolor=AAAAAAFF

verifcolor=AAAAAAFF
wrongcolor=DF2D2DFF
greetercolor=AAAAAAFF

layoutcolor=FFFFFFFF

i3lock --image=$TMPBG  \
    --pass-media-keys --keylayout 0 --layoutcolor=$layoutcolor \
    --clock --force-clock --timepos="w/2:h/2" --timesize=96 --timecolor=FFFFFFFF \
    --datestr="$DATE" --datepos="tx:ty+80" --datesize=32 --datecolor=FFFFFFFF \
    --indpos="w/2-r/2:h-r*2" --radius 20 \
    --ringcolor=$ringcolor --insidecolor=$insidecolor --linecolor=$linecolor \
    --separatorcolor=$separatorcolor --ringvercolor=$ringvercolor \
    --insidevercolor=$insidevercolor --veriftext='Verifying password' --verifcolor=$verifcolor --ringwrongcolor=$ringwrongcolor \
    --insidewrongcolor=$insidewrongcolor --wrongtext='Wrong password' --wrongcolor=$wrongcolor --keyhlcolor=$keyhlcolor \
    --bshlcolor=$bshlcolor --noinputtext='' --greetertext="Screen locked" --greetercolor=$greetercolor

rm $TMPBG