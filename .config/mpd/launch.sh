#!/bin/bash
if ! pgrep -x "mpd"
then
	[ ! -s ~/.config/mpd/pid ] && mpd
fi


if ! pgrep -x "mpd-rpc" > /dev/null
then
	mpd-rpc -h=/home/nise/.config/mpd/socket &
fi


