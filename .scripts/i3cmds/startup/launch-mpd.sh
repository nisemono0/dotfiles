#!/bin/bash
if ! pgrep -x "mpd"
then
	[ ! -s ~/.config/mpd/pid ] && mpd
fi

