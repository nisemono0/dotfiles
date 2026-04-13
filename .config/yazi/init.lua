-- Mine
-- Add some ui features
require("enhanced-ui"):setup()

-- Confirm when quitting multiple tabs
require("confirm-quit")

-- Move to next/prev parent dir
require("move-parentdir")

-- Preview audio files as spectrograms
require("audio-preview")

-- Preview 1st image in zip files
require("mangathumb")

-- Open files with command
require("open-with-cmd")

-- Preview media files
require("simple-mediainfo")



-- Downloaded (w/o setup)
-- yazi-rs/plugins:chmod
require("chmod")

-- pirafrank/what-size
require("what-size")

-- boydaihungst/compress
require("compress")



-- Downloaded (w/ setup)
-- yazi-rs/plugins:full-border
require("full-border"):setup {
    -- Available values: ui.border.{ PLAIN, ROUNDED, DOUBLE, THICK, QUADRANT_INSIDE, QUADRANT_OUTSIDE }
    type = ui.Border.PLAIN
}

-- yazi-rs/plugins:smart-enter
require("smart-enter"):setup {
    open_multi = true
}

-- AnirudhG07/plugins-yazi:copy-file-contents
require("copy-file-contents"):setup {
    notification = true
}

-- dedukun/bookmarks
require("bookmarks"):setup {
    last_directory = { enable = true, persist = true, mode = "jump", key = "`" },
    persist = "all",
    desc_format = "full",
    file_pick_mode = "parent",
    custom_desc_input = false,
    show_keys = true,
    notify = {
        enable = true,
        timeout = 1.5,
        message = {
            new = "New bookmark '<key>' -> '<folder>'",
            delete = "Deleted bookmark in '<key>'",
            delete_all = "Deleted all bookmarks",
        },
    },
}

-- AminurAlam/yazi-plugins:spot
require('spot'):setup {
  metadata_section = {
    enable = true,
    hash_cmd = 'cksum', -- other hashing commands can be slower
    hash_filesize_limit = 150, -- in MB, set 0 to disable
    relative_time = true,
    time_format = '%Y-%m-%d %H:%M', -- https://www.man7.org/linux/man-pages/man3/strftime.3.html
  },
  plugins_section = {
    enable = true,
  },
  style = {
    section = 'green',
    key = 'reset',
    value = 'blue',
    colorize_metadata = true,
    height = 20,
    width = 60,
    key_length = 15,
  },
}

-- yazi-rs/plugins:git
th.git = th.git or {}
th.git.unknown_sign = ""
th.git.modified_sign = "M"
th.git.added_sign = "A"
th.git.untracked_sign = "?"
th.git.ignored_sign = "I"
th.git.deleted_sign = "D"
th.git.updated_sign = "U"
th.git.clean_sign = " "
require("git"):setup {
    -- Order of status signs showing in the linemode
    order = 1500,
}

