#!/bin/bash

# Gives a dmenu prompt to mount unmounted drives and Android phones
# You'll be prompted to give a mountpoint from already existing directories
# If a new directory is given it will ask to create it

. $HOME/.dmenurc

android_drives="$(simple-mtpfs -l 2>/dev/null)"
usb_drives="$(lsblk -rnpo "NAME,LABEL,SIZE,TYPE,MOUNTPOINT" |
    awk '/part $|rom $/ { printf "%s %s (%s)\n",$1,$2,$3 }' |
    sort -t ' ' -k 2n)"

mountusb() {
    chosen="$(echo "$usb_drives" | dmenu "${DMENU_ARGS_CENTER[@]}" -p "Mount which drive" | awk '{print $1}')"
    [ -z "$chosen" ] && exit 1
    notify-send "$(udisksctl mount -b "$chosen")" -i drive-harddisk || notify-send -u critical "There was a problem while mounting"
}

mountandroid() {
    chosen="$(echo "$android_drives" | dmenu "${DMENU_ARGS_CENTER[@]}" -p "Which Android device" | cut -d ':' -f 1)"
    [ -z "$chosen" ] && exit 1

    mount_point="$(find "$HOME" -maxdepth 3 -not -path "*.*" -type d 2>/dev/null | 
        dmenu "${DMENU_ARGS_CENTER[@]}" -p "Type in mount point")"
    mount_point="${mount_point/#\~/$HOME}"
    [ -z "$mount_point" ] && exit 1

    if [ ! -d "$mount_point" ]; then
        askmkdir="$(printf "No\\nYes" | dmenu "${DMENU_ARGS_CENTER[@]}" -p "Create: $mount_point")"
        [ "$askmkdir" = "Yes" ] && (mkdir -p "$mount_point" || sudo -A mkdir -p "$mount_point") || exit 1
    fi

    simple-mtpfs --device "$chosen" "$mount_point"
    echo "Ok" | dmenu "${DMENU_ARGS_CENTER[@]}" -p "Tap Allow on your phone if it asks for permission and then press enter" || exit 1
    simple-mtpfs --device "$chosen" "$mount_point"
    notify-send "Android Mounting" "Android device mounted to $mount_point." -i media-flash
}

askmount() {
    case "$(printf "USB\\nAndroid" | dmenu "${DMENU_ARGS_CENTER[@]}" -p "Mount a USB drive or Android device")" in
        "USB")
            mountusb
            ;;
        "Android")
            mountandroid
            ;;
        *) exit 1 ;;
    esac
}

if [ -z "$usb_drives" ]; then
    [ -z "$android_drives" ] && notify-send "No USB drive or Android device detected" && exit
    echo "Android device(s) detected"
    mountandroid
else
    if [ -z "$android_drives" ]; then
        echo "USB drive(s) detected"
        mountusb
    else
        echo "Mountable USB drive(s) and Android device(s) detected"
        askmount
    fi
fi

