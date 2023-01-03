#!/usr/bin/bash
#
# Take a screenshot and display a notification.
#
# Created by Dylan Araps.
#
# Depends on: imagemagick, libnotify (patched with id support)

# Edited

# Screenshot directory
scr_dir="${HOME}/Pictures/Screenshot"
mkdir -p "$scr_dir" || { notify-send -u critical "Couldn't create screenshot directory"; exit; }

# Use printf to store the current date/time as variables.
printf -v date "%(%F)T"
printf -v time "%(%I-%M-%S)T"

# Create current date format.
mkdir -p "${scr_dir}/${date}"

# Name the screenshot
scr="${scr_dir}/${date}/${date}-${time}.png"

if maim --hidecursor --capturebackground "$scr"; then
    notify-send "Saved screenshot as ${scr/*\/}" -i "${scr}"
fi