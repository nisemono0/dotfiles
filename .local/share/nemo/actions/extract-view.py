#!/usr/bin/python3 -OOt

import os
from shutil import rmtree
from subprocess import call
from sys import argv
from tempfile import mkdtemp

if len(argv) != 2:
    cmd = ["notify-send", "-u", "critical", "Something went wrong !"]
    call(cmd)
    exit(-1)

tmp_folder = mkdtemp(prefix="nemo-img-view-")
file_name = argv[1]

def clear_tmp(tmp):
    if os.path.exists(tmp):
        rmtree(tmp)

def extract(archive, folder):
    try:
        cmd = ["notify-send", "Extracting...", "-i", "package-x-generic"]
        call(cmd)
        cmd = ["aunpack", "-X", folder, archive]
        call(cmd)
    except OSError:
        cmd = ["notify-send", "-u", "critical", "Aunpack not found !"]
        call(cmd)
        clear_tmp(folder)
        exit(-1)

def show(folder):
    try:
        # Pretty whack, should find a better way one day
        cmd = "find {0} -type f | sort -V | nsxiv -i".format(folder)
        call(cmd, shell=True)
    except OSError:
        cmd = ["notify-send", "-u", "critical", "nsxiv not found !"]
        call(cmd)
        clear_tmp(folder)
        exit(-1)


extract(file_name, tmp_folder)
show(tmp_folder)
clear_tmp(tmp_folder)
