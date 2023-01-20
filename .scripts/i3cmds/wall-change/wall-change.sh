#!/bin/bash
. $HOME/.dmenurc

ALL_WALLPAPERS_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/wallpapers"
S_WALLPAPERS_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/wallpapers/s"
Q_WALLPAPERS_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/wallpapers/q"
E_WALLPAPERS_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/wallpapers/e"

DEFAULT_WALLPAPER="${XDG_CONFIG_HOME:-$HOME/.config}/wallpapers/default"

TMP_WALLPAPER="/tmp/wallpaper-tmp"

backend=""
saturation=""

reset_wallpaper(){
	hsetroot -cover "$DEFAULT_WALLPAPER"
    xrdb -load "$HOME/.Xresources"
	python "$HOME/.scripts/i3cmds/wall-change/reset-colors.py"
	i3-msg reload &>/dev/null
	pkill -USR1 polybar
    rm -f -- "$TMP_WALLPAPER"
    notify-send "Wallpaper and colors reset" -i video-display
    exit 0
}

set_wal_options(){
    case $(printf "haishoku\\nwal\\ncolorz\\ncolorthief" | dmenu $DMENU_OPTIONS -fn "$DMENU_FN" -p "Select backend") in
        "haishoku") backend="haishoku" ;;
        "wal") backend="wal" ;;
        "colorz") backend="colorz" ;;
        "colorthief") backend="colorthief" ;;
        *) exit ;;
    esac

    options_sat=$(seq 0.1 0.1 1.0)
    options_sat="Default"$'\n'"$options_sat"
    saturation=$(printf "%s\n" "${options_sat[@]}" | dmenu $DMENU_OPTIONS -fn "$DMENU_FN" -p "Select or type in saturation (0.1-1.0)")
    [[ -z "$saturation" ]] && exit 1
}

change_colors(){
    if [[ -f "$TMP_WALLPAPER" ]]; then
        set_wal_options
        wal -c
        if [[ "$saturation" = "Default" ]]; then
            wal -ntq --backend "$backend" -i "$TMP_WALLPAPER" || exit 1 
        else
            wal -ntq --saturate "$saturation" --backend "$backend" -i "$TMP_WALLPAPER" || exit 1
        fi
    else
        notify-send "You must first set a wallpaper with this script"
    fi
}

copy_wallpaper() {
    if [ -f "$TMP_WALLPAPER" ]; then
        copy_path="$(find "$HOME" -maxdepth 3 -not -path "*.*" -type d 2>/dev/null | 
		    dmenu $DMENU_OPTIONS -fn "$DMENU_FN" -p "Copy where")"
    	copy_path="${copy_path/#\~/$HOME}"
    	[ -z "$copy_path" ] && exit 1

        if [ ! -d "$copy_path" ]; then
	    	askmkdir="$(printf "No\\nYes" | dmenu $DMENU_OPTIONS -fn "$DMENU_FN" -p "Create: $copy_path")"
		    [ "$askmkdir" = "Yes" ] && (mkdir -p "$copy_path") || exit 1
	    fi

        if cp "$TMP_WALLPAPER" "$copy_path"; then
            notify-send "Wallpaper copied succesfully"
        else
            notify-send -u critical "Couldn't copy wallpaper"
        fi
    else
        notify-send "You must first set a wallpaper with this script"
        exit 0
    fi
}

set_wallpaper(){
    wallpapers_dir="$1"
    wallpaper="$(find "$wallpapers_dir" -type f | sort -V | nsxiv -N wallpapers-thumbnail -ito -g 900x600 | shuf -n 1)"

    [[ -z "$wallpaper" ]] && exit 1

    set_wal_options

    hsetroot -cover "$wallpaper" || exit 1

    ln -sf "$wallpaper" "$TMP_WALLPAPER"

    if [[ "$saturation" = "Default" ]]; then
        wal -ntq --backend "$backend" -i "$wallpaper" || exit 1 
    else
        wal -ntq --saturate "$saturation" --backend "$backend" -i "$wallpaper" || exit 1
    fi
    
    notify-send "Wallpaper and colors updated" -i video-display

    exit 0
}

case $(printf "All\\nSafe\\nQuestionable\\nExplicit\\nChange colors\\nCopy wallpaper\\nReset" | dmenu $DMENU_OPTIONS -fn "$DMENU_FN" -p "Select option") in
    "All") set_wallpaper "$ALL_WALLPAPERS_DIR" ;;
    "Safe") set_wallpaper "$S_WALLPAPERS_DIR" ;;
    "Questionable") set_wallpaper "$Q_WALLPAPERS_DIR" ;;
    "Explicit") set_wallpaper "$E_WALLPAPERS_DIR" ;;
    "Change colors") change_colors ;;
    "Copy wallpaper") copy_wallpaper ;;
    "Reset") reset_wallpaper ;;
    *) exit ;;
esac

