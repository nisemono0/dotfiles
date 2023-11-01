#!/bin/bash

# A dmenu prompt to unmount drives.
# Provides you with mounted partitions, select one to unmount.
# Drives mounted at /, /boot and /home will not be options to unmount.

. $HOME/.dmenurc

drives="$(lsblk -rnpo "NAME,TYPE,SIZE,MOUNTPOINT" | awk '$4!~/\/boot|\/home$|SWAP/&&length($4)>1{printf "%s (%s)\n",$4,$3}')"

unmountusb() {
    chosen="$(echo "$drives" | dmenu "${DMENU_ARGS_CENTER[@]}" -p "Unmount" | awk '{print $1}')"
    [ -z "$chosen" ] && exit
    sudo -A umount "$chosen" && notify-send "Unmounted $chosen" -i drive-harddisk
}

unmountandroid() {
    chosen="$(awk '/simple-mtpfs/ {print $2}' /etc/mtab | dmenu "${DMENU_ARGS_CENTER[@]}" -p "Unmount which device")"
    [ -z "$chosen" ] && exit
    sudo -A umount -l "$chosen" && notify-send "Android unmounting" "$chosen unmounted." -i media-flash
}

askunmount() {
    case "$(printf "USB\\nAndroid" | dmenu "${DMENU_ARGS_CENTER[@]}" -p "Mount a USB drive or Android device")" in
        "USB")
            unmountusb
            ;;
        "Android")
            unmountandroid
            ;;
        *) exit 1 ;;
    esac
}

if ! grep simple-mtpfs /etc/mtab; then
    [ -z "$drives" ] && echo "No drives to unmount" &&  exit
    echo "Unmountable USB drive detected"
    unmountusb
else
    if [ -z "$drives" ]; then
        echo "Unmountable Android device detected"
        unmountandroid
    else
        echo "Unmountable USB drive(s) and Android device(s) detected"
        askunmount
    fi
fi
