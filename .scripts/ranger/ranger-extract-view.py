#!/usr/bin/python3 -OOt

import os
from shutil import rmtree
from subprocess import check_call
from sys import argv

tmp_folder = "/tmp/archive_view"

if len(argv) != 2:
    cmd = ["notify-send", "-u", "critical", "Something went wrong !"]
    check_call(cmd)
    exit(-1)

file_name = argv[1]

def clear_dir(folder):
    for the_file in os.listdir(folder):
        file_path = os.path.join(folder, the_file)
        try:
            if os.path.isfile(file_path):
                os.unlink(file_path)
            elif os.path.isdir(file_path):
                rmtree(file_path)
        except:
            cmd = ["notify-send", "-u", "critical", "Something went wrong when clearing /tmp !"]
            check_call(cmd)
            exit(-1)

def extract(archive, folder):
    if not os.path.exists(folder): # If folder does not exist, create it
        os.mkdir(folder)
    else:                              # Otherwise delete w/e is inside
        clear_dir(folder)
    try:
        cmd = ["notify-send", "Extracting..."]
        check_call(cmd)
        cmd = ["aunpack", "-X", folder, archive]
        check_call(cmd)
    except:
        cmd = ["notify-send", "-u", "critical", "Something went wrong while extracting !"]
        check_call(cmd)
        exit(-1)

def show(folder):
    try:
        cmd = ["feh", "-r", folder]
        check_call(cmd)
    except:
        cmd = ["notify-send", "-u", "critical", "Something went wrong while opening images !"]
        check_call(cmd)
        exit(-1)


extract(file_name, tmp_folder)
show(tmp_folder)
clear_dir(tmp_folder)
