#!/bin/bash
. $HOME/.dmenurc

TMP_WALLPAPER="/tmp/wallpaper-tmp"

DEFAULT_WALLPAPER="${XDG_CONFIG_HOME:-$HOME/.config}/wallpapers/default"

default_resolution=""
resolution_type=""
width=""
height=""

rating=""
search=""

backend=""
saturation=""

set_resolution() {
    select_resolution () {
        case $(printf "Exact\\nGreater" | dmenu $DMENU_OPTIONS -fn "$DMENU_FN" -p "Select resolution type") in
            "Exact")
                resolution_type="exact"
            ;;
            "Greater")
                resolution_type="greater"
            ;;
            *) exit ;;
        esac

        case $(printf "1080p\\n1440p\\n1800p\\n2160p\\n2880p\\n4320p" | dmenu $DMENU_OPTIONS -fn "$DMENU_FN" -p "Resolution") in
            "1080p")
                width="1920"
                height="1080"
                ;;
            "1440p")
                width="2560"
                height="1440"
                ;;
            "1800p")
                width="3200"
                height="1800"
                ;;
            "2160p")
                width="3840"
                height="2160"
                ;;
            "2880p")
                width="5120"
                height="2880"
                ;;
            "4320p")
                width="7680"
                height="4320"
                ;;
            *) exit ;;
        esac
    }
    case $(printf "Yes\\nNo" | dmenu $DMENU_OPTIONS -fn "$DMENU_FN" -p "Use default resolution?") in
        "Yes")
            default_resolution="true"
            ;;
        "No")
            default_resolution="false"
            select_resolution
            ;;
        *) exit ;;
    esac
}

set_rating () {
    case $(printf "Safe\\nEcchi\\nHentai\\nSafe+Ecchi\\nEcchi+Hentai\\nAll" | dmenu $DMENU_OPTIONS -fn "$DMENU_FN" -p "Select rating") in
        "Safe") rating="safe" ;;
        "Ecchi") rating="ecchi" ;;
        "Hentai") rating="hentai" ;;
        "Safe+Ecchi") rating="safe+ecchi" ;;
        "Ecchi+Hentai") rating="ecchi+hentai" ;;
        "All") rating="all" ;;
        *) exit ;;
    esac
}

set_search() {
    search=$(printf "" | dmenu $DMENU_OPTIONS -fn "$DMENU_FN" -p "Search tags")
}

download_image() {
    if [[ "$1" = "null" ]] || [[ "$1" = "" ]]; then
        notify-send -h string:x-dunst-stack-tag:wallpaperchange "Couldn't get any image url"
        exit
    else
        if [ -f "$TMP_WALLPAPER" ]; then
            rm -- -f "$TMP_WALLPAPER"
        fi
        if ! curl -f -sS "$1" -o "$TMP_WALLPAPER"; then
            notify-send -h string:x-dunst-stack-tag:wallpaperchange "Couldn't retrieve the image"
            exit
        fi
    fi
}

set_wal_options() {
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

change_colors() {
    if [[ -f "$TMP_WALLPAPER" ]]; then
        set_wal_options
        wal -c
        if [[ "$saturation" = "Default" ]]; then
            wal -ntq --backend "$backend" -i "$TMP_WALLPAPER" || exit 1
        else
            wal -ntq --saturate "$saturation" --backend "$backend" -i "$TMP_WALLPAPER" || exit 1
        fi
        notify-send -h string:x-dunst-stack-tag:wallpaperchange "Colors updated" -i video-display
    else
        notify-send -h string:x-dunst-stack-tag:wallpaperchange "You must first set a wallpaper with this script"
    fi
}

reset_wallpaper() {
	hsetroot -cover "$DEFAULT_WALLPAPER"
    xrdb -load "$HOME/.Xresources"
	python "$HOME/.scripts/i3cmds/wall-change/reset-colors.py"
	i3-msg reload &>/dev/null
	pkill -USR1 polybar
    if [ -f "$TMP_WALLPAPER" ]; then
        rm -f -- "$TMP_WALLPAPER"
    fi
    notify-send -h string:x-dunst-stack-tag:wallpaperchange "Wallpaper and colors reset" -i video-display
    exit 0
}

set_wallpaper() {
    hsetroot -cover "$TMP_WALLPAPER" || exit 1

    wal -c
    if [[ "$saturation" = "Default" ]]; then
        wal -ntq --backend "$backend" -i "$TMP_WALLPAPER" || exit 1
    else
        wal -ntq --saturate "$saturation" --backend "$backend" -i "$TMP_WALLPAPER" || exit 1
    fi

    notify-send -h string:x-dunst-stack-tag:wallpaperchange "Wallpaper and colors updated" -i video-display
}

copy_to() {
    if [ -f "$TMP_WALLPAPER" ]; then
        copy_path="$(find "$HOME" -maxdepth 3 -not -path "*.*" -type d 2>/dev/null | 
		    dmenu $DMENU_OPTIONS -fn "$DMENU_FN" -p "Copy where")"
    	copy_path="${copy_path/#\~/$HOME}"
    	[ -z "$copy_path" ] && exit 1

        if [ ! -d "$copy_path" ]; then
	    	askmkdir="$(printf "No\\nYes" | dmenu $DMENU_OPTIONS -fn "$DMENU_FN" -p "Create: $copy_path")"
		    [ "$askmkdir" = "Yes" ] && (mkdir -p "$copy_path") || exit 1
	    fi

        filename=$(basename "$TMP_WALLPAPER")
        extension=$(file -b --extension "$TMP_WALLPAPER" | cut -d '/' -f 1)

        if [[ "$extension" == "???" ]]; then
            cpfile="${filename}"
        else
            cpfile="${filename}.${extension}"
        fi

        if cp --backup=numbered "$TMP_WALLPAPER" "${copy_path}/${cpfile}"; then
            notify-send -h string:x-dunst-stack-tag:wallpaperchange "Wallpaper copied succesfully"
        else
            notify-send -u critical "Couldn't copy wallpaper"
        fi
    else
        notify-send -h string:x-dunst-stack-tag:wallpaperchange "You must first set a wallpaper with this script"
        exit 0
    fi
}

copy_clipboard() {
    if [ -f "$TMP_WALLPAPER" ]; then
        filetype=$(file -b --dereference --mime-type "$TMP_WALLPAPER" | tr -d ' ')
        if [[ "$filetype" == image/* ]]; then
            if [[ "$filetype" == image/png ]]; then
                xclip -selection clipboard -target image/png -i "$TMP_WALLPAPER" &> /dev/null && notify-send "Image copied to clipbooard" -i "$TMP_WALLPAPER" || notify-send -u critical "Something went wrong"
            else
                convert "$TMP_WALLPAPER" png:- | xclip -selection clipboard -target image/png -i &> /dev/null && notify-send "Image copied to clipbooard" -i "$TMP_WALLPAPER" || notify-send -u critical "Something went wrong"
            fi
        else
            notify-send "Can only copy images to clipboard"
        fi
    else
        notify-send -h string:x-dunst-stack-tag:wallpaperchange "You must first set a wallpaper with this script"
        exit 0
    fi
}

random_konachan() {
    url="https://konachan.com/post.json"

    set_resolution
    set_rating
    set_search
    set_wal_options

    if [[ "$default_resolution" = "true" ]]; then
        width="width:1920.."
        height="width:1080.."
    else
        width="width:$width"
        height="height:$height"
        if [[ "$resolution_type" == "greater" ]]; then
            width="$width.."
            height="$height.."
        fi
    fi

    case "$rating" in
        "safe") rating="rating:safe" ;;
        "ecchi") rating="rating:questionable" ;;
        "hentai") rating="rating:explicit" ;;
        "safe+ecchi") rating="rating:questionableless" ;;
        "ecchi+hentai") rating="rating:questionableplus" ;;
        "all") rating="" ;;
        *) exit ;;
    esac

    limit="limit=1"
    query="tags=order:random $width $height $rating $search"

    img_url=$(curl -G -f -sS --data-urlencode "$limit" --data-urlencode "$query" "$url" | jq -r '.[0].file_url')
    download_image "$img_url"
    set_wallpaper
}

random_wallhaven() {
    KEY=""
    url="https://wallhaven.cc/api/v1/search"

    set_resolution
    set_rating
    set_search
    set_wal_options

    if [[ "$default_resolution" = "true" ]]; then
        resolution="atleast=1920x1080"
    else
        if [[ "$resolution_type" == "greater" ]]; then
            resolution="atleast=${width}x${height}"
        else
            resolution="resolutions=${width}x${height}"
        fi
    fi

    case "$rating" in
        "safe") rating="purity=100" ;;
        "ecchi") rating="purity=010" ;;
        "hentai") rating="purity=001" ;;
        "safe+ecchi") rating="purity=110" ;;
        "ecchi+hentai") rating="purity=011" ;;
        "all") rating="purity=111" ;;
        *) exit ;;
    esac

    categories="categories=010"
    ratio="ratios=16x9"
    sorting="sorting=random"
    query="q=$search"

    img_url=$(curl -G -f -sS \
            --data-urlencode "$KEY" \
            --data-urlencode "$categories" \
            --data-urlencode "$ratio" \
            --data-urlencode "$sorting" \
            --data-urlencode "$rating" \
            --data-urlencode "$resolution" \
            --data-urlencode "$query" \
            "$url" | jq -r '.data[0].path')
    
    download_image "$img_url"
    set_wallpaper
}


case $(printf "Konachan Random\\nWallhaven Random\\nChange colors\\nCopy to\\nCopy clipboard\\nReset wallpaper" | dmenu $DMENU_OPTIONS -fn "$DMENU_FN" -p "Select option") in
    "Konachan Random")
        random_konachan
        ;;
    "Wallhaven Random")
        random_wallhaven
        ;;    
    "Change colors")
        change_colors
        ;;
    "Copy to")
        copy_to
        ;;
    "Copy clipboard")
        copy_clipboard
        ;;
    "Reset wallpaper") 
        reset_wallpaper
        ;;
    *) exit ;;
esac
