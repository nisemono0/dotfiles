#!/bin/bash

[ $# -ne 2 ] && echo "Too few/many arguments, expecting 2" && exit 1

case "$1" in
    -m|--move) # Move focused container to nextws
        nextws="$(( $(i3-msg -t get_workspaces | jq '.[] | select(.focused).num') + $2 ))"
        i3-msg move container to workspace "$nextws"
        ;;
    -f|--follow) # Move focused container to nextws and follow it
        nextws="$(( $(i3-msg -t get_workspaces | jq '.[] | select(.focused).num') + $2 ))"
        i3-msg move container to workspace "$nextws"
        i3-msg workspace "$nextws"
        ;;
    -g|--goto) # Go to nextws without doing anything
        nextws="$(( $(i3-msg -t get_workspaces | jq '.[] | select(.focused).num') + $2 ))"
        i3-msg workspace "$nextws"
        ;;
    *)
        echo "$0 <-m,--move | -f,--follow | -g,--goto> <INT>"
        exit 1
        ;;
esac
