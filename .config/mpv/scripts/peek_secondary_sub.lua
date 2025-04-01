local mp = require("mp")
local msg = require("mp.msg")

local was_pressed = nil
local prev_pause_state = nil

local function peek_secondary_sub(ev, pause_vid)
    local is_ssid_loaded = mp.get_property_native("secondary-sid")
    if not is_ssid_loaded then
        return
    end

    local is_ssid_visible = mp.get_property_native("secondary-sub-visibility")

    if ev.event == "down" then
        if is_ssid_visible then
            return
        end

        prev_pause_state = mp.get_property_native("pause")

        if pause_vid then
            mp.set_property_bool("pause", true)
        end

        mp.set_property_bool("secondary-sub-visibility", true)
        was_pressed = true
    elseif ev.event == "up" then
        if is_ssid_visible and was_pressed then
            if pause_vid and prev_pause_state == false then
                mp.set_property_bool("pause", false)
            end
            mp.set_property_bool("secondary-sub-visibility", false)
            was_pressed = false
        end
    end
end

local function handler_pause(ev)
    peek_secondary_sub(ev, true)
end

local function handler_no_pause(ev)
    peek_secondary_sub(ev, false)
end

mp.add_key_binding('k', 'peek-secondary-sub-no-pause', handler_no_pause, { complex = true })
mp.add_key_binding('Alt+k', 'peek-secondary-sub-pause', handler_pause, { complex = true })
