#!/bin/bash

xbacklight -inc 20 || notify-send -u critical "Something went wrong"
