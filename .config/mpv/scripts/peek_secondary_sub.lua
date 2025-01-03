local mp = require("mp")
local msg = require("mp.msg")

local was_held = false

local function peek_secondary_sub(key)
    local is_ssid_loaded = mp.get_property_native("secondary-sid")
    local is_ssid_visible = mp.get_property_native("secondary-sub-visibility")

    if not is_ssid_loaded then
        return
    end

    if key.event == "down" or key.event == "repeat" then
        if is_ssid_visible then
            return
        end
        mp.set_property_bool("secondary-sub-visibility", true)
        was_held = true
    elseif key.event == "up" then
        if was_held then
            mp.set_property_bool("secondary-sub-visibility", false)
            was_held = false
        end
    end
end

mp.add_key_binding('Alt+V', 'peek-secondary-sub', peek_secondary_sub, { complex = true })
mp.add_key_binding('k', 'peek-secondary-sub', peek_secondary_sub, { complex = true })
