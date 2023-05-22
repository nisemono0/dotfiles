#!/bin/sh

total_updates(){
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
}

detail_updates(){
    echo "=====[Official]====="
    if ! checkupdates; then
        echo "No official updates"
    fi
    echo "=====[AUR]====="
    if ! yay -Qum 2> /dev/null; then
        echo "No AUR updates"
    fi

    read -rsn 1
}

case "$1" in
    --total)
        total_updates
        ;;
    --detail)
        detail_updates
        ;;
    *)
        exit 1
        ;;
esac
