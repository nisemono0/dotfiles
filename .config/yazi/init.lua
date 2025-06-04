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

