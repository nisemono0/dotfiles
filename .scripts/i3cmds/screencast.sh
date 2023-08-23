#!/bin/bash

. $HOME/.dmenurc

PIDFILE=/tmp/screencast_pid
CAST_DIR="${HOME}/Videos/Screencast"

mkdir -p "${CAST_DIR}" || { notify-send -u critical "Couldn't create screencast directory"; exit; }

check_screencast() {
    if [ -f "${PIDFILE}" ]; then
        PID=$(cat "${PIDFILE}")
        if [ -n "$(ps -p "${PID}" -o pid=)" ]; then
            selection=$(printf "Stop\\nContinue" | dmenu "${DMENU_ARGS[@]}" -p "Screencast in progress")
            case "${selection}" in
                "Stop")
                    kill "${PID}"
                    notify-send -i video-display "Screencast ended"
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

set_format() {
    format=$(printf "webm\\nmp4\\nmkv" | dmenu "${DMENU_ARGS[@]}" -p "Output format")
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

set_audio() {
    case $(printf "Yes\\nNo" | dmenu "${DMENU_ARGS[@]}" -p "Record audio") in
        "Yes") audio="Yes" ;;
        "No") audio="No" ;;
        *) exit ;;
    esac
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

start_screencast() {
    width="$1"
    height="$2"
    x="$3"
    y="$4"

    set_format
    set_framerate
    set_scale
    set_crf
    set_preset
    set_audio

    printf -v date "%(%F)T"
    printf -v time "%(%I-%M-%S)T"

    mkdir -p "${CAST_DIR}/${date}"

    output="${CAST_DIR}/${date}/${date}-${time}.${format}"

    if [ "${audio}" = "Yes" ]; then
        sink="$(pactl info | sed -En 's/Default Sink: (.*)/\1/p').monitor"
        ffmpeg -v 8 -y -f pulse -i "${sink}" -f x11grab -video_size "${width}"x"${height}" \
            -framerate "${framerate}" -i :0.0+"${x}","${y}" -preset "${preset}" \
            -crf "${crf}" -vf scale="${scale}" "${output}" &
    else
        ffmpeg -v 8 -y -f x11grab -video_size "${width}"x"${height}" \
            -framerate "${framerate}" -i :0.0+"${x}","${y}" -preset "${preset}" \
            -crf "${crf}" -vf scale="${scale}" "${output}" &
    fi

    notify-send -i video-display "Screencast started"
    FFMPEG_PID=$!
    echo ${FFMPEG_PID} > ${PIDFILE}
}

check_screencast

dimensions=$(printf "Fullscreen\\nRegion" | dmenu "${DMENU_ARGS[@]}" -p "Dimensions")
case "${dimensions}" in
    "Fullscreen")
        read -r width height <<< "$(xdpyinfo | awk -F'[ x]+' '/dimensions:/{print $3, $4}')"
        x=0
        y=0
        start_screencast "${width}" "${height}" "${x}" "${y}"
        ;;
    "Region")
        read -r width height x y <<<"$(slop --bordersize 2 --format='%w %h %x %y')"
        start_screencast "${width}" "${height}" "${x}" "${y}"
        ;;
    *) exit ;;
esac
