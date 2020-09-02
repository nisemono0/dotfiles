#!/bin/bash

filename=$1
filenr=$2
totalfiles=$3
imgsize=$4
width=$5
height=$6
zoom=$7

printf "File Name: ${filename} \nImage number:[${filenr}/${totalfiles}] \nImage Size: ${imgsize}\nDimensions: ${width}x${height}\nZoom: ${zoom}"

