#!/usr/bin/python3 -OOt

import os
from shutil import rmtree
from subprocess import call
from sys import argv

tmp_folder = "/tmp/archive_view"

if len(argv) != 2:
    cmd = ["notify-send", "-u", "critical", "Something went wrong !"]
    call(cmd)
    exit(-1)

file_name = argv[1]

def clear_tmp(folder):
    for the_file in os.listdir(folder):
        file_path = os.path.join(folder, the_file)
        try:
            if os.path.isfile(file_path):
                os.unlink(file_path)
            elif os.path.isdir(file_path):
                rmtree(file_path)
        except:
            cmd = ["notify-send", "-u", "critical", "Something went wrong when clearing /tmp/archive_view !"]
            call(cmd)
            exit(-1)

def extract(archive, folder):
    if not os.path.exists(folder): # If folder does not exist, create it
        os.mkdir(folder)
    else:                              # Otherwise delete w/e is inside
        for the_file in os.listdir(folder):
            file_path = os.path.join(folder, the_file)
            try:
                if os.path.isfile(file_path):
                    os.unlink(file_path)
                elif os.path.isdir(file_path): 
                    rmtree(file_path)
            except:
                cmd = ["notify-send", "-u", "critical", "Something went wrong !"]
                call(cmd)
                exit(-1)
    try:
        cmd = ["notify-send", "Extracting..."]
        call(cmd)
        cmd = ["aunpack", "-X", folder, archive]
        call(cmd)
    except:
        cmd = ["notify-send", "-u", "critical", "Something went wrong while extracting !"]
        call(cmd)
        exit(-1)

def show(folder):
    try:
        cmd = ["feh", "-r", folder]
        call(cmd)
    except:
        cmd = ["notify-send", "-u", "critical", "Something went wrong while opening images !"]
        call(cmd)
        exit(-1)

extract(file_name, tmp_folder)
show(tmp_folder)
clear_tmp(tmp_folder)