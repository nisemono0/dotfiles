-- 9xpe5i edited

-- Assume initial mode is 'auto', actual mode is in osc.lua and cannot be read
local osc_always_on = false

local function toggle_osc_auto_always()
    osc_always_on = not osc_always_on
    mp.commandv('script-message', 'osc-visibility',
        osc_always_on and 'always' or 'auto'
    )
end

mp.add_key_binding(nil, 'toggle-osc-auto-always', toggle_osc_auto_always)