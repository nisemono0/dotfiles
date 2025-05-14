-- Local
-- Add some ui features
require("enhanced-ui"):setup()

-- Downloaded
-- yazi-rs/plugins:chmod
require("chmod")

-- yazi-rs/plugins:full-border
require("full-border"):setup {
    -- Available values: ui.border.{ PLAIN, ROUNDED, DOUBLE, THICK, QUADRANT_INSIDE, QUADRANT_OUTSIDE }
    type = ui.Border.PLAIN
}

-- yazi-rs/plugins:smart-enter
require("smart-enter"):setup {
    open_multi = true
}

-- pirafrank/what-size
require("what-size")

-- AnirudhG07/plugins-yazi:copy-file-contents
require("copy-file-contents"):setup {
    notification = true
}

-- Ape/open-with-cmd
require("open-with-cmd")
require("bookmarks"):setup {
    last_directory = { enable = true, persist = false, mode = "dir" },
    persist = "all",
    desc_format = "full",
    file_pick_mode = "parent",
    custom_desc_input = false,
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

-- boydaihungst/compress
require("compress")
