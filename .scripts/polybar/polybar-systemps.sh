#!/bin/bash

SENSORS="$(sensors -j)"
# sensors -j
CPU_JQ=""
GPU_JQ=""

cpu_temp=$(jq -r "$CPU_JQ // -128" <<< "$SENSORS")
gpu_temp=$(jq -r "$GPU_JQ // -128" <<< "$SENSORS")

printf "%.1f°C %.1f°C" "$cpu_temp" "$gpu_temp"
