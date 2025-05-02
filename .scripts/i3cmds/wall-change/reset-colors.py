#!/bin/python

# Some code taken from pywal

import glob
import os
from subprocess import getoutput


def create_dir(directory):
    """Alias to create the cache dir."""
    os.makedirs(directory, exist_ok=True)


def save_file(data, export_file):
    """Write data to a file."""
    create_dir(os.path.dirname(export_file))

    try:
        with open(export_file, "w") as file:
            file.write(data)
    except PermissionError:
        print("No permissions")
        exit()


def set_special(index, color, iterm_name="h"):
    """Convert a hex color to a special sequence."""
    return "\033]%s;%s\033\\" % (index, color)


def set_color(index, color):
    """Convert a hex color to a text color sequence."""
    return "\033]4;%s;%s\033\\" % (index, color)


def create_sequences(colors, vte_fix=False):
    # Colors 0-15.
    sequences = [set_color(index, colors["colors"]["color%s" % index])
                 for index in range(16)]

    # Special colors.
    # Source: https://goo.gl/KcoQgP
    # 10 = foreground, 11 = background, 12 = cursor foreground
    # 13 = mouse foreground, 708 = background border color.
    sequences.extend([
        set_special(10, colors["special"]["foreground"], "g"),
        set_special(11, colors["special"]["background"], "h"),
        set_special(12, colors["special"]["cursor"], "l"),
        set_special(13, colors["special"]["foreground"], "j"),
        set_special(17, colors["special"]["foreground"], "k"),
        set_special(19, colors["special"]["background"], "m"),
        set_color(232, colors["special"]["background"]),
        set_color(256, colors["special"]["foreground"]),
        set_color(257, colors["special"]["background"]),
    ])

    if not vte_fix:
        sequences.extend(
            set_special(708, colors["special"]["background"], "")
        )
    return "".join(sequences)


def get_colors():
    """Create colors dict based on current xrdb loaded colors"""
    colors = {
        "special": {
            "background": "{background}",
            "foreground": "{foreground}",
            "cursor": "{cursor}"
        },
        "colors": {
            "color0": "{color0}",
            "color1": "{color1}",
            "color2": "{color2}",
            "color3": "{color3}",
            "color4": "{color4}",
            "color5": "{color5}",
            "color6": "{color6}",
            "color7": "{color7}",
            "color8": "{color8}",
            "color9": "{color9}",
            "color10": "{color10}",
            "color11": "{color11}",
            "color12": "{color12}",
            "color13": "{color13}",
            "color14": "{color14}",
            "color15": "{color15}"
        }
    }

    bg = getoutput("xrdb -query | grep -w '*background' | cut -f 2")
    fg = getoutput("xrdb -query | grep -w '*foreground' | cut -f 2")
    curs = getoutput("xrdb -query | grep -w 'cursorColor' -m 1 | cut -f 2")

    colors["special"]["background"] = bg
    colors["special"]["foreground"] = fg
    colors["special"]["cursor"] = curs

    for col in range(16):
        colors["colors"]["color{}".format(col)] = getoutput("xrdb -query | grep -w '*color{}' | cut -f 2".format(col))

    return colors


tty_pattern = "/dev/pts/[0-9]*"
colors = get_colors()
sequences = create_sequences(colors, False)

# Writing to "/dev/pts/[0-9] lets you send data to open terminals.
for term in glob.glob(tty_pattern):
    save_file(sequences, term)
