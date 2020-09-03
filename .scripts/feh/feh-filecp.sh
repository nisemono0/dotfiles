#!/bin/bash

cp --backup=numbered "$1" ~/Pictures/Feh && notify-send "Image copied to Feh directory" || notify-send -u critical "Something went wrong"
