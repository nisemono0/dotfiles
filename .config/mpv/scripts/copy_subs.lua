local mp = require("mp")
local msg = require("mp.msg")
local mpopts = require("mp.options")

local opts = {
    remove_newlines                = true,
    remove_leading_trailing_spaces = true,
}
mpopts.read_options(opts)

local copy_cmd = {}
local autocopy_subs = false

-- Linux (X11): xclip
-- Linux (wayland): wl-copy
local platform = mp.get_property_native("platform")
if platform == "linux" then
    if os.getenv("XDG_SESSION_TYPE") == "wayland" then
        copy_cmd = { "wl-copy" }
    else
        copy_cmd = { "xclip", "-i", "-selection", "clipboard" }
    end
else
    msg.error("Only Linux is supported")
    return nil
end

local function remove_newlines(str)
    return str:gsub('[\n\r]+', ' ')
end

local function remove_leading_trailing_spaces(str)
    return str:gsub('^%s*(.-)%s*$', '%1')
end

local function copy_subtitle(prop)
    local sub_text = mp.get_property(prop)
    if not sub_text or sub_text == "" then
        return
    end

    if opts.remove_newlines then
        sub_text = remove_newlines(sub_text)
    end

    if opts.remove_leading_trailing_spaces then
        sub_text = remove_leading_trailing_spaces(sub_text)
    end

    mp.command_native_async(
        {
            name = "subprocess",
            args = copy_cmd,
            stdin_data = sub_text,
            -- detach = true
        },
        function(success, result, error)
            if not success or result.status ~= 0 then
                mp.osd_message("Error copying subtitle, check terminal/console")
            end
        end
    )
end

local function autocopy_handler()
    copy_subtitle("sub-text")
end

local function toggle_sub_autocopy()
    if autocopy_subs then
        mp.unobserve_property(autocopy_handler)
        mp.osd_message("Autocopy subtitle disabled")
        autocopy_subs = false
    else
        mp.observe_property("sub-text", "string", autocopy_handler)
        mp.osd_message("Autocopy subtitle enabled")
        autocopy_subs = true
    end
end


mp.add_key_binding("Ctrl+c", "copy-primary-sub", function() copy_subtitle("sub-text") end)
mp.add_key_binding("Alt+c", "copy-secondary-sub", function() copy_subtitle("secondary-sub-text") end)
mp.add_key_binding("Ctrl+Alt+c", "toggle-sub-autocopy", toggle_sub_autocopy)

