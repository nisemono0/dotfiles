#!/bin/bash
. $HOME/.dmenurc

TMP_WALLPAPER="/tmp/wallpaper-tmp"

WALLCHANGE="$(dirname "$0")/wall-change.sh"

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
        notify-send -h string:x-dunst-stack-tag:wallpapernotifs "Couldn't get any image url"
        exit
    else
        if [ -f "$TMP_WALLPAPER" ]; then
            rm -- -f "$TMP_WALLPAPER"
        fi
        if ! curl -f -sS "$1" -o "$TMP_WALLPAPER"; then
            notify-send -h string:x-dunst-stack-tag:wallpapernotifs "Couldn't retrieve the image"
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
    . "$WALLCHANGE" --change-colors
}

reset_wallpaper() {
    . "$WALLCHANGE" --reset
}

set_wallpaper() {
    hsetroot -cover "$TMP_WALLPAPER" || exit 1

    wal -c
    if [[ "$saturation" = "Default" ]]; then
        wal -ntq --backend "$backend" -i "$TMP_WALLPAPER" || exit 1
    else
        wal -ntq --saturate "$saturation" --backend "$backend" -i "$TMP_WALLPAPER" || exit 1
    fi

    notify-send -h string:x-dunst-stack-tag:wallpapernotifs "Wallpaper and colors updated" -i video-display
}

copy_to() {
    . "$WALLCHANGE" --copy-to
}

copy_clipboard() {
    . "$WALLCHANGE" --copy-clipboard
}

konachan() {
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

wallhaven() {
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

random_local() {
    . "$WALLCHANGE" --random-menu
}

case $(printf "Konachan\\nWallhaven\\nRandom local\\nChange colors\\nCopy to\\nCopy clipboard\\nReset" | dmenu $DMENU_OPTIONS -fn "$DMENU_FN" -p "Select option") in
    "Konachan") konachan ;;
    "Wallhaven") wallhaven ;;
    "Random local") random_local ;;
    "Change colors") change_colors ;;
    "Copy to") copy_to ;;
    "Copy clipboard") copy_clipboard ;;
    "Reset") reset_wallpaper ;;
    *) exit ;;
esac
