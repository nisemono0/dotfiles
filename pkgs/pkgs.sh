#!/bin/bash
pacman -Qqen | awk 'NR==FNR{a[$0];next} !($0 in a)' excludedpkgs.txt - > mainpkgs.txt
pacman -Qqem | awk 'NR==FNR{a[$0];next} !($0 in a)' excludedpkgs.txt - > foreignpkgs.txt
comm -13 <(pacman -Qqdt | sort) <(pacman -Qqdtt | sort) > optdeplist.txt
pip freeze > piplist.txt
