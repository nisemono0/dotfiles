-- Local
require("enhanced-ui"):setup()

-- Downloaded
require("full-border"):setup {
    -- Available values: ui.border.{ PLAIN, ROUNDED, DOUBLE, THICK, QUADRANT_INSIDE, QUADRANT_OUTSIDE }
    type = ui.Border.PLAIN
}
require("copy-file-contents"):setup {
    notification = true
}
require("bookmarks"):setup {
    last_directory = { enable = true, persist = false, mode = "dir" },
    persist = "all",
    desc_format = "full",
    file_pick_mode = "hover",
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
