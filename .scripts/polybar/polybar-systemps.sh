#!/bin/bash

SENSORS="$(sensors -j)"
CPU_JQ=".\"k10temp-pci-00c3\".Tctl.temp1_input"
GPU_JQ=".\"amdgpu-pci-1c00\".edge.temp1_input"

cpu_temp=$(jq -r "$CPU_JQ // -128" <<< "$SENSORS")
gpu_temp=$(jq -r "$GPU_JQ // -128" <<< "$SENSORS")

printf "%.1f°C %.1f°C" "$cpu_temp" "$gpu_temp"
