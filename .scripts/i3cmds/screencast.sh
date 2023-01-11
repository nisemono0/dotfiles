#!/bin/bash

. $HOME/.dmenurc

PIDFILE=/tmp/screencast_pid
CAST_DIR="${HOME}/Videos/Screencast"

mkdir -p "${CAST_DIR}" || { notify-send -u critical "Couldn't create screencast directory"; exit; }

check_screencast() {
    if [ -f "${PIDFILE}" ]; then
        PID=$(cat "${PIDFILE}")
        if [ -n "$(ps -p "${PID}" -o pid=)" ]; then
            selection=$(printf "Stop\\nContinue" | dmenu -fn "$DMENU_FN" $DMENU_OPTIONS -p "Screencast in progress")
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

start_screencast() {
    width="$1"
    height="$2"
    x="$3"
    y="$4"

    format=$(printf "webm\\nmp4\\nmkv" | dmenu -fn "$DMENU_FN" $DMENU_OPTIONS -p "Output format")
    [ -z "${format}" ] && exit 1

    framerate=$(printf "15\\n30\\n60" | dmenu -fn "$DMENU_FN" $DMENU_OPTIONS -p "Framerate")
    [ -z "${framerate}" ] && exit 1

    audio=$(printf "Yes\\nNo" | dmenu -fn "$DMENU_FN" $DMENU_OPTIONS -p "Record audio")
    [ -z "${audio}" ] && exit 1

    printf -v date "%(%F)T"
    printf -v time "%(%I-%M-%S)T"

    mkdir -p "${CAST_DIR}/${date}"

    output="${CAST_DIR}/${date}/${date}-${time}.${format}"

    if [ "${audio}" = "Yes" ]; then
        sink="$(pactl info | sed -En 's/Default Sink: (.*)/\1/p').monitor"
        ffmpeg -v 8 -y -f x11grab -video_size "${width}"x"${height}" -framerate "${framerate}" -i :0.0+"${x}","${y}" -f pulse -i "${sink}" "${output}" &
    else
        ffmpeg -v 8 -y -f x11grab -video_size "${width}"x"${height}" -framerate "${framerate}" -i :0.0+"${x}","${y}" "${output}" &
    fi

    notify-send -i video-display "Screencast started"
    FFMPEG_PID=$!
    echo ${FFMPEG_PID} > ${PIDFILE}
}

check_screencast

dimensions=$(printf "Fullscreen\\nRegion" | dmenu -fn "$DMENU_FN" $DMENU_OPTIONS -p "Dimensions")
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
