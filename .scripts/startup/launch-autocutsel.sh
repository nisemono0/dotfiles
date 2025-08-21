#!/bin/bash

if ! pgrep -x "autocutsel"; then
    autocutsel -fork &
    autocutsel -selection CLIPBOARD &
fi
