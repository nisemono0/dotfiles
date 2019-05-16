#!/bin/bash -e

TMPBG=/tmp/screen_locked.png

# Take a screenshot
scrot $TMPBG

# Pixellate it 10x
mogrify -scale 10% -scale 1000% $TMPBG

# Lock screen displaying this image.
i3lock -i $TMPBG

rm $TMPBG
