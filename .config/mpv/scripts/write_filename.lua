local mp = require("mp")
local msg = require("mp.msg")
local utils = require("mp.utils")
local mpopts = require("mp.options")

local opt = {
    out_dir = [[]],
    out_file = "watched.txt",
    write_on_load = false,
    message_duration = 4
}

mpopts.read_options(opt)

function get_playing_file()
    return mp.get_property("filename")
end

function get_savefile()
    if opt.out_dir ~= "" then
        return utils.join_path(opt.out_dir, opt.out_file)
    end
    return opt.out_file
end

function text_exists(file, text)
    for line in file:lines() do
        if text == line then
            return true
        end
    end
    return false
end

function write_filename()
    save_file = get_savefile()
    playing_file = get_playing_file()

    file = io.open(save_file, "a+")
    if file == nil then
        format_msg = string.format("Could not open: \"%s\"", save_file)
        mp.osd_message(format_msg, opt.message_duration)
        msg.error(format_msg)
    else
        if not text_exists(file, playing_file) then
            file:write(playing_file, "\n")
            file:flush()
            format_msg = string.format("Wrote \"%s\" to \"%s\"", playing_file, save_file)
            mp.osd_message(format_msg, opt.message_duration)
        end
        file:close()
    end
end

if opt.write_on_load then
    mp.register_event("file-loaded", write_filename)
end

mp.add_key_binding("w", "write_filename", write_filename)
