#!/bin/bash
. $HOME/.dmenurc

change_sink(){
    sink="$1"
    pacmd set-default-sink "$sink" || exit 1
    new_index=$(pacmd list-sinks | awk '$1 == "*" && $2 == "index:" {print $3}')
    inputs=$(pacmd list-sink-inputs | awk '$1 == "index:" {print $2}')
    for INPUT in $inputs ; do
        pacmd move-sink-input "$INPUT" "$new_index"
    done

    description=$(pacmd list-sinks | awk '$1 == "device.description" {print substr($0,5+length($1 $2))}' | \
                  sed 's/"//g' | awk 'NR==v1{print$0}' v1=$((new_index+1)))
    notify-send "Output changed to $description" -i audio-headphones
    exit 0
}

selection="$(pacmd list-sinks | awk '$1 == "name:" {print $2}' | tr -d '<>' | dmenu -fn "$DMENU_FN" $DMENU_OPTIONS -p "Select output sink")"

[ -z "$selection" ] && exit 0
change_sink "$selection"