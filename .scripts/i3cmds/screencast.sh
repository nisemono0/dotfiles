#!/bin/bash

. $HOME/.dmenurc

PIDFILE=/tmp/screencast_pid
CAST_DIR="${HOME}/Videos/Screencast"

DUNST_ICON="video-display"

check_screencast() {
    if [ -f "${PIDFILE}" ]; then
        PID=$(cat "${PIDFILE}")
        if [ -n "$(ps -p "${PID}" -o pid=)" ]; then
            selection=$(printf "Stop\\nContinue" | dmenu "${DMENU_ARGS[@]}" -p "Screencast in progress")
            case "${selection}" in
                "Stop")
                    kill "${PID}"
                    notify-send -i "$DUNST_ICON" "Screencast ended"
                    rm "${PIDFILE}"
                    exit 0
                    ;;
                "Continue") exit ;;
                *) exit ;;
            esac
        else
            echo "Wrong pidfile"
            rm "${PIDFILE}"
        fi
    fi
}

set_savepath() {
    default_path=$(printf "Yes\\nNo" | dmenu "${DMENU_ARGS[@]}" -p "Use default save path")
    [ -z "$default_path" ] && exit 1

    if [ "$default_path" = "No" ]; then
        save_path="$(find "$HOME" -maxdepth 3 -not -path "*.*" -type d,l 2>/dev/null |
            dmenu "${DMENU_ARGS[@]}" -p "Type in save directory")"
        save_path="${save_path/#\~/$HOME}"
        [ -z "$save_path" ] && exit 1
        if [ ! -d "$save_path" ]; then
            askmkdir=$(printf "Yes\\nNo" | dmenu "${DMENU_ARGS[@]}" -p "Create: $save_path")
            if [ "$askmkdir" = "Yes" ]; then
                mkdir -p "$save_path" && CAST_DIR="$save_path"
            else
                exit 1
            fi
        else
            CAST_DIR="$save_path"
        fi
    fi

}

set_format() {
    format=$(printf "mp4\\nmkv\\nwebm" | dmenu "${DMENU_ARGS[@]}" -p "Output format")
    [ -z "${format}" ] && exit 1
}

set_framerate() {
    framerate=$(printf "15\\n30\\n60" | dmenu "${DMENU_ARGS[@]}" -p "Framerate")
    [ -z "${framerate}" ] && exit 1
}

set_scale() {
    case $(printf "No scale\\n900p\\n720p\\n540p\\n480p" | dmenu "${DMENU_ARGS[@]}" -p "Video scale") in
        "No scale") scale="-1:-1" ;;
        "900p") scale="-1:900" ;;
        "720p") scale="-1:720" ;;
        "540p") scale="-1:540" ;;
        "480p") scale="-1:480" ;;
        *) exit ;;
    esac
}

set_crf() {
    crf=$(printf "Default" | dmenu "${DMENU_ARGS[@]}" -p "Input CRF or use default (23)")
    [ -z "${crf}" ] && exit 1
    if [ "${crf}" = "Default" ]; then
        crf="23"
    fi
}

set_preset() {
    case $(printf "medium\\nfast\\nfaster\\nveryfast\\nsuperfast\\nultrafast\\nslow\\nslower\\nveryslow" | dmenu "${DMENU_ARGS[@]}" -p "Preset") in
        "medium") preset="medium" ;;
        "fast") preset="fast" ;;
        "faster") preset="faster" ;;
        "veryfast") preset="veryfast" ;;
        "superfast") preset="superfast" ;;
        "ultrafast") preset="ultrafast" ;;
        "slow") preset="slow" ;;
        "slower") preset="slower" ;;
        "veryslow") preset="veryslow" ;;
        *) exit ;;
    esac
}

set_audio() {
    case $(printf "Yes\\nNo" | dmenu "${DMENU_ARGS[@]}" -p "Record audio") in
        "Yes") audio="Yes" ;;
        "No") audio="No" ;;
        *) exit ;;
    esac
}

set_mouse() {
    case $(printf "Yes\\nNo" | dmenu "${DMENU_ARGS[@]}" -p "Record mouse cursor") in
        "Yes") mouse="1" ;;
        "No") mouse="0" ;;
        *) exit ;;
    esac
}

create_output() {
    printf -v date "%(%F)T"
    printf -v time "%(%I-%M-%S)T"

    mkdir -p "${CAST_DIR}/${date}"

    output="${CAST_DIR}/${date}/${date}-${time}.${format}"
}

show_ffmpeg_notif() {
    if [ "${mouse}" == "1" ]; then
        mouse_notif="Yes"
    else
        mouse_notif="No"
    fi

    notify-send -i "$DUNST_ICON" "Screencast started" \
        "Path: ${CAST_DIR}\nVideo: ${width}x${height}+${x}+${y} ${scale}@${framerate}fps\nEncode: ${crf}CRF ${preset} preset\nAudio: ${audio}\nMouse: ${mouse_notif}"
}

start_screencast() {
    width="$1"
    height="$2"
    x="$3"
    y="$4"

    set_savepath
    set_format
    set_framerate
    set_scale
    set_crf
    set_preset
    set_audio
    set_mouse

    create_output

    if [ "${audio}" = "Yes" ]; then
        sink="$(pactl info | sed -En 's/Default Sink: (.*)/\1/p').monitor"
        ffmpeg -v 8 -y -f pulse -i "${sink}" -f x11grab -draw_mouse "${mouse}" -video_size "${width}"x"${height}" \
            -framerate "${framerate}" -i :0.0+"${x}","${y}" -preset "${preset}" \
            -crf "${crf}" -vf scale="${scale}" "${output}" &
    else
        ffmpeg -v 8 -y -f x11grab -draw_mouse "${mouse}" -video_size "${width}"x"${height}" \
            -framerate "${framerate}" -i :0.0+"${x}","${y}" -preset "${preset}" \
            -crf "${crf}" -vf scale="${scale}" "${output}" &
    fi

    FFMPEG_PID=$!
    echo ${FFMPEG_PID} > ${PIDFILE}

    show_ffmpeg_notif
}

start_preset_screencast() {
    presets=$(printf "Fullscreen 720p@60fps 21CRF fast preset audio nomouse\\nFullscreen No Scale@60fps 21CRF fast preset audio mouse\\nRegion No Scale@60fps 21CRF fast preset audio mouse\\nRegion No Scale@60fps 21CRF fast preset audio nomouse" | dmenu "${DMENU_ARGS[@]}" -p "Select preset")
    [ -z "${presets}" ] && exit 1

    format="mp4"

    case "${presets}" in
        "Fullscreen 720p@60fps 21CRF fast preset audio nomouse")
            read -r width height <<< "$(xdpyinfo | awk -F'[ x]+' '/dimensions:/{print $3, $4}')"
            x=0
            y=0
            framerate="60"
            scale="-1:720"
            crf="21"
            preset="fast"
            audio="Yes"
            sink="$(pactl info | sed -En 's/Default Sink: (.*)/\1/p').monitor"
            mouse=0
            create_output

            ffmpeg -v 8 -y -f pulse -i "${sink}" -f x11grab -draw_mouse "${mouse}" -video_size "${width}"x"${height}" \
                -framerate "${framerate}" -i :0.0+"${x}","${y}" -preset "${preset}" \
                -crf "${crf}" -vf scale="${scale}" "$output" &
            FFMPEG_PID=$!
            echo ${FFMPEG_PID} > ${PIDFILE}
            ;;
        "Fullscreen No Scale@60fps 21CRF fast preset audio mouse")
            read -r width height <<< "$(xdpyinfo | awk -F'[ x]+' '/dimensions:/{print $3, $4}')"
            x=0
            y=0
            framerate="60"
            scale="-1:-1"
            crf="21"
            preset="fast"
            create_output
            audio="Yes"
            sink="$(pactl info | sed -En 's/Default Sink: (.*)/\1/p').monitor"
            mouse=1

            ffmpeg -v 8 -y -f pulse -i "${sink}" -f x11grab -draw_mouse "${mouse}" -video_size "${width}"x"${height}" \
                -framerate "${framerate}" -i :0.0+"${x}","${y}" -preset "${preset}" \
                -crf "${crf}" -vf scale="${scale}" "$output" &
            FFMPEG_PID=$!
            echo ${FFMPEG_PID} > ${PIDFILE}
            ;;
        "Region No Scale@60fps 21CRF fast preset audio mouse")
            read -r width height x y <<<"$(slop --bordersize 2 -n --format='%w %h %x %y')"
            ([ -z "$width" ] || [ -z "$height" ] || [ -z "$x" ] || [ -z "$y" ]) && exit
            framerate="60"
            scale="-1:-1"
            crf="21"
            preset="fast"
            create_output
            audio="Yes"
            sink="$(pactl info | sed -En 's/Default Sink: (.*)/\1/p').monitor"
            mouse=1

            ffmpeg -v 8 -y -f pulse -i "${sink}" -f x11grab -draw_mouse "${mouse}" -video_size "${width}"x"${height}" \
                -framerate "${framerate}" -i :0.0+"${x}","${y}" -preset "${preset}" \
                -crf "${crf}" -vf scale="${scale}" "$output" &
            FFMPEG_PID=$!
            echo ${FFMPEG_PID} > ${PIDFILE}
            ;;
        "Region No Scale@60fps 21CRF fast preset audio nomouse")
            read -r width height x y <<<"$(slop --bordersize 2 -n --format='%w %h %x %y')"
            ([ -z "$width" ] || [ -z "$height" ] || [ -z "$x" ] || [ -z "$y" ]) && exit
            framerate="60"
            scale="-1:-1"
            crf="21"
            preset="fast"
            create_output
            audio="Yes"
            sink="$(pactl info | sed -En 's/Default Sink: (.*)/\1/p').monitor"
            mouse=0

            ffmpeg -v 8 -y -f pulse -i "${sink}" -f x11grab -draw_mouse "${mouse}" -video_size "${width}"x"${height}" \
                -framerate "${framerate}" -i :0.0+"${x}","${y}" -preset "${preset}" \
                -crf "${crf}" -vf scale="${scale}" "$output" &
            FFMPEG_PID=$!
            echo ${FFMPEG_PID} > ${PIDFILE}
            ;;
        *) exit ;;
    esac
    show_ffmpeg_notif
}

check_screencast

selection=$(printf "Fullscreen\\nRegion\\nPreset" | dmenu "${DMENU_ARGS[@]}" -p "Select option")
case "${selection}" in
    "Fullscreen")
        read -r width height <<< "$(xdpyinfo | awk -F'[ x]+' '/dimensions:/{print $3, $4}')"
        x=0
        y=0
        start_screencast "${width}" "${height}" "${x}" "${y}"
        ;;
    "Region")
        read -r width height x y <<< "$(slop --bordersize 2 -n --format='%w %h %x %y')"
        ([ -z "$width" ] || [ -z "$height" ] || [ -z "$x" ] || [ -z "$y" ]) && exit
        start_screencast "${width}" "${height}" "${x}" "${y}"
        ;;
    "Preset")
        start_preset_screencast
        ;;
    *) exit ;;
esac
