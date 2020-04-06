#!/bin/bash

$(pacman -Qqe > pkglist.txt)
$(pip freeze > piplist.txt)