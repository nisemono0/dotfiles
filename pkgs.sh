#!/bin/bash

$(pacman -Qqe > allpkgs.txt)
$(pacman -Qqet > mainpkgs.txt)
$(pacman -Qqem > foreignpkgs.txt)
$(comm -13 <(pacman -Qqdt | sort) <(pacman -Qqdtt | sort) > optdeplist.txt)
$(pip freeze > piplist.txt)
