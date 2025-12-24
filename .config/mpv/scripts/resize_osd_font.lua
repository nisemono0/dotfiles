local mp = require("mp")

local DEFAULT_FONT_SIZE = mp.get_property_number("osd-font-size")
local STEP = 1

local function increase_osd_font_size()
    local curr_osd_font_size = mp.get_property_number("osd-font-size")
    local new_osd_font_size = curr_osd_font_size + STEP
    mp.set_property_number("osd-font-size", new_osd_font_size)
    mp.osd_message("OSD font size: " .. new_osd_font_size)
end

local function decrease_osd_font_size()
    local curr_osd_font_size = mp.get_property_number("osd-font-size")
    local new_osd_font_size = curr_osd_font_size - STEP
    mp.set_property_number("osd-font-size", new_osd_font_size)
    mp.osd_message("OSD font size: " .. new_osd_font_size)
end

local function reset_osd_font_size()
    mp.set_property_number("osd-font-size", DEFAULT_FONT_SIZE)
    mp.osd_message("OSD font size reset")
end

mp.add_key_binding("e", "increase-osd-font-size", increase_osd_font_size, { repeatable = true })
mp.add_key_binding("E", "decrease-osd-font-size", decrease_osd_font_size, { repeatable = true })
mp.add_key_binding("Alt+e", "reset-osd-font-size", reset_osd_font_size)

