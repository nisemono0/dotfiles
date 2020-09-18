#!/bin/bash
. $HOME/.dmenurc

WALLPAPER_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"/wallpapers

reset_wall(){
    default_wall=$(find "${XDG_CONFIG_HOME:-$HOME/.config}"/wallpapers -type f -name "default.*")
	feh --no-fehbg --bg-fill "$default_wall"
    xrdb -load "$HOME/.Xresources"
	python "$HOME/.scripts/i3cmds/wall-change/reset-colors.py"
	i3-msg reload &>/dev/null
	pkill -USR1 polybar
    exit 0
}

set_wall(){
    wallpaper="$1"
    bkend="$2"
    sat="$3"

    feh --no-fehbg --bg-fill "$wallpaper" || exit 1

    if [ "$sat" = "Default" ] ; then
        wal -ntq -a "99" --backend "$bkend" -i "$wallpaper" || exit 1 
    else
        wal -ntq -a "99" --saturate "$sat" --backend "$bkend" -i "$wallpaper" || exit 1
    fi
}

options_walls=$(find "$WALLPAPER_DIR" -type f -printf "%f\n" | sort -V)
options_walls="Reset"$'\n'"$options_walls"
selected_wall=$(printf "%s\n" "${options_walls[@]}" | dmenu $OPTIONS -p "Select wallpaper")
[ -z "$selected_wall" ] && exit 1
[ "$selected_wall" = "Reset" ] && reset_wall
wallpaper_path="$WALLPAPER_DIR/$selected_wall"

bkends="haishoku\nwal\ncolorz\ncolorthief"
selected_bkend=$(echo -e "$bkends" | dmenu $OPTIONS -p "Select backend")
[ -z "$selected_bkend" ] && exit 1

options_sat=$(seq 0.1 0.1 1.0)
options_sat="Default"$'\n'"$options_sat"
selected_sat=$(printf "%s\n" "${options_sat[@]}" | dmenu $OPTIONS -p "Select or type in saturation (0.1-1.0)")
[ -z "$selected_sat" ] && exit 1

set_wall "$wallpaper_path" "$selected_bkend" "$selected_sat"
