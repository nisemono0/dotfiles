#!/bin/sh

if ! main_updates=$(checkupdates 2> /dev/null | wc -l ); then
    main_updates=0
fi

if ! aur_updates=$(yay -Qum 2> /dev/null | wc -l); then
    aur_updates=0
fi

total_updates=$((main_updates + aur_updates))

if [ "$total_updates" -gt 0 ]; then
    echo "# $main_updates:$aur_updates"
else
    echo ""
fi
