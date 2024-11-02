#!/bin/bash
. $HOME/.dmenurc

# Last scratchpad window
# i3-msg -t get_tree | jq -r '.nodes.[].nodes.[].nodes.[]|select(.name=="__i3_scratch").floating_nodes[-1].nodes[0].id'

readarray -t win_list <<< "$(i3-msg -rt get_tree | jq -er '.nodes.[].nodes.[].nodes.[]|select(.name=="__i3_scratch").floating_nodes.[].nodes.[]|(.name|tostring) + " (" + (.id|tostring) + ")"')"
[ "${#win_list[@]}" = 0 ] && exit 1

show_window() {
    window_id="$1"
    i3-msg "[con_id=${window_id}] scratchpad show"
}

if [ "${#win_list[@]}" = 1 ] && [ "${win_list[0]}" = "" ]; then
    echo "No windows in scratchpad, exiting ..."
    exit 1
else
    sel_win=$(printf "%s\n" "${win_list[@]}" | dmenu "${DMENU_ARGS_CENTER[@]}" -p "Select window" -fn "Noto Sans CJK JP:style=Bold:size=9")
    [ -z "$sel_win" ] && exit 1
    if [[ "${win_list[@]}" =~ "$sel_win" ]]; then
        id=$(awk -F"[()]" '{print $(NF-1)}' <<< "$sel_win")
        show_window "$id"
    fi
fi

