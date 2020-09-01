#!/usr/bin/bash
#
# Take a screenshot and display a notification.
#
# Created by Dylan Araps.
#
# Depends on: imagemagick, libnotify (patched with id support)

# Edited by me

# Screenshot directory
scr_dir="${HOME}/Pictures/Scrot/Arch"
mkdir -p "$scr_dir" || { printf "%s\n" "Error: Couldn't create screenshot directory"; exit; }

# Use printf to store the current date/time as variables.
printf -v date "%(%F)T"
printf -v time "%(%I-%M-%S)T"

# Create current date format.
mkdir -p "${scr_dir}/${date}"

# Name the screenshot
scr="${scr_dir}/${date}/${date}-${time}.png"

sleep 0.2 ; scrot -s -f "$scr" && notify-send "Saved screenshot as ${scr/*\/}" || notify-send -u critical "Something went wrong"
