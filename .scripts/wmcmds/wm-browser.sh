#!/bin/bash

case "$1" in
    --run) firefox ;;
    --run-private) firefox --private-window ;;
    *) exit 1 ;;
esac

