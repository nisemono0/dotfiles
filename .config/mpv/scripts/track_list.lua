--[[
    * track-list.lua v.2023-05-21
    *
    * AUTHORS: dyphire
    * License: MIT
    * link: https://github.com/dyphire/mpv-scripts
    * Edited

    This script implements an interractive track list
    Usage: add bindings to input.conf, ones below are the default set here
    -- nil script-binding track_list/toggle-vidtrack-browser
    -- ALT+SHARP script-binding track_list/toggle-audtrack-browser
    -- ALT+j script-binding track_list/toggle-subtrack-browser
    -- ALT+J script-binding track_list/toggle-secondary-subtrack-browser

    Original script edited to include scroll-list.lua + other stuff changed
    https://github.com/CogentRedTester/mpv-scroll-list
]]

local mp = require 'mp'
local opts = require("mp.options")
local propNative = mp.get_property_native

--[[
    scroll-list.lua SECTION END
    Assign scroll_list:new() to access the scroll menu
]]
local scroll_list = {
    global_style = [[]],
    header_style = [[{\q2\fs35\c&00ccff&}]],
    list_style = [[{\q2\fs25\c&Hffffff&}]],
    wrapper_style = [[{\c&00ccff&\fs16}]],
    cursor_style = [[{\c&00ccff&}]],
    selected_style = [[{\c&Hfce788&}]],

    cursor = [[➤\h]],
    indent = [[\h\h\h\h]],

    num_entries = 16,
    wrap = false,
    empty_text = "no entries"
}

--formats strings for ass handling
--this function is based on a similar function from https://github.com/mpv-player/mpv/blob/master/player/lua/console.lua#L110
function scroll_list.ass_escape(str, replace_newline)
    if replace_newline == true then replace_newline = "\\\239\187\191n" end

    --escape the invalid single characters
    str = str:gsub('[\\{}\n]', {
        -- There is no escape for '\' in ASS (I think?) but '\' is used verbatim if
        -- it isn't followed by a recognised character, so add a zero-width
        -- non-breaking space
        ['\\'] = '\\\239\187\191',
        ['{'] = '\\{',
        ['}'] = '\\}',
        -- Precede newlines with a ZWNBSP to prevent ASS's weird collapsing of
        -- consecutive newlines
        ['\n'] = '\239\187\191\\N',
    })

    -- Turn leading spaces into hard spaces to prevent ASS from stripping them
    str = str:gsub('\\N ', '\\N\\h')
    str = str:gsub('^ ', '\\h')

    if replace_newline then
        str = str:gsub("\\N", replace_newline)
    end
    return str
end

--format and return the header string
function scroll_list:format_header_string(str)
    return str
end

--appends the entered text to the overlay
function scroll_list:append(text)
        if text == nil then return end
        self.ass.data = self.ass.data .. text
    end

--appends a newline character to the osd
function scroll_list:newline()
    self.ass.data = self.ass.data .. '\\N'
end

--re-parses the list into an ass string
--if the list is closed then it flags an update on the next open
function scroll_list:update()
    if self.hidden then self.flag_update = true
    else self:update_ass() end
end

--prints the header to the overlay
function scroll_list:format_header()
    self:append(self.header_style)
    self:append(self:format_header_string(self.header))
    self:newline()
end

--formats each line of the list and prints it to the overlay
function scroll_list:format_line(index, item)
    self:append(self.list_style)

    if index == self.selected then self:append(self.cursor_style..self.cursor..self.selected_style)
    else self:append(self.indent) end

    self:append(item.style)
    self:append(item.ass)
    self:newline()
end

--refreshes the ass text using the contents of the list
function scroll_list:update_ass()
    self.ass.data = self.global_style
    self:format_header()

    if #self.list < 1 then
        self:append(self.empty_text)
        self.ass:update()
        return
    end

    local start = 1
    local finish = start+self.num_entries-1

    --handling cursor positioning
    local mid = math.ceil(self.num_entries/2)+1
    if self.selected+mid > finish then
        local offset = self.selected - finish + mid

        --if we've overshot the end of the list then undo some of the offset
        if finish + offset > #self.list then
            offset = offset - ((finish+offset) - #self.list)
        end

        start = start + offset
        finish = finish + offset
    end

    --making sure that we don't overstep the boundaries
    if start < 1 then start = 1 end
    local overflow = finish < #self.list
    --this is necessary when the number of items in the dir is less than the max
    if not overflow then finish = #self.list end

    --adding a header to show there are items above in the list
    if start > 1 then self:append(self.wrapper_style..(start-1)..' item(s) above\\N\\N') end

    for i=start, finish do
        self:format_line(i, self.list[i])
    end

    if overflow then self:append('\\N'..self.wrapper_style..#self.list-finish..' item(s) remaining') end
    self.ass:update()
end

--moves the selector down the list
function scroll_list:scroll_down()
    if self.selected < #self.list then
        self.selected = self.selected + 1
        self:update_ass()
    elseif self.wrap then
        self.selected = 1
        self:update_ass()
    end
end

--moves the selector up the list
function scroll_list:scroll_up()
    if self.selected > 1 then
        self.selected = self.selected - 1
        self:update_ass()
    elseif self.wrap then
        self.selected = #self.list
        self:update_ass()
    end
end

--moves the selector to the list next page
function scroll_list:move_pagedown()
    if #self.list > self.num_entries then
        self.selected = self.selected + self.num_entries
        if self.selected > #self.list then self.selected = #self.list end
        self:update_ass()
    end
end

--moves the selector to the list previous page
function scroll_list:move_pageup()
    if #self.list > self.num_entries then
        self.selected = self.selected - self.num_entries
        if self.selected < 1 then self.selected = 1 end
        self:update_ass()
    end
end

--moves the selector to the list begin
function scroll_list:move_begin()
    if #self.list > 1 then
        self.selected = 1
        self:update_ass()
    end
end

--moves the selector to the list end
function scroll_list:move_end()
    if #self.list > 1 then
        self.selected = #self.list
        self:update_ass()
    end
end

--adds the forced keybinds
function scroll_list:add_keybinds()
    for _,v in ipairs(self.keybinds) do
        mp.add_forced_key_binding(v[1], 'dynamic/'..self.ass.id..'/'..v[2], v[3], v[4])
    end
end

--removes the forced keybinds
function scroll_list:remove_keybinds()
    for _,v in ipairs(self.keybinds) do
        mp.remove_key_binding('dynamic/'..self.ass.id..'/'..v[2])
    end
end

--opens the list and sets the hidden flag
function scroll_list:open_list()
    self.hidden = false
    if not self.flag_update then self.ass:update()
    else self.flag_update = false ; self:update_ass() end
end

--closes the list and sets the hidden flag
function scroll_list:close_list()
    self.hidden = true
    self.ass:remove()
end

--modifiable function that opens the list
function scroll_list:open()
    if self.hidden then self:add_keybinds() end
    self:open_list()
end

--modifiable function that closes the list
function scroll_list:close()
    self:remove_keybinds()
    self:close_list()
end

--toggles the list
function scroll_list:toggle()
    if self.hidden then self:open()
    else self:close() end
end

--clears the list in-place
function scroll_list:clear()
    local i = 1
    while self.list[i] do
        self.list[i] = nil
        i = i + 1
    end
end

--added alias for ipairs(list.list) for lua 5.1
function scroll_list:ipairs()
    return ipairs(self.list)
end

--append item to the end of the list
function scroll_list:insert(item)
    self.list[#self.list + 1] = item
end

local metatable = {
    __index = function(t, key)
        if scroll_list[key] ~= nil then return scroll_list[key]
        elseif key == "__current" then return t.list[t.selected]
        elseif type(key) == "number" then return t.list[key] end
    end,
    __newindex = function(t, key, value)
        if type(key) == "number" then rawset(t.list, key, value)
        else rawset(t, key, value) end
    end,
    __scroll_list = scroll_list,
    __len = function(t) return #t.list end,
    __ipairs = function(t) return ipairs(t.list) end
}

--creates a new list object
function scroll_list:new()
    local vars
    vars = {
        ass = mp.create_osd_overlay('ass-events'),
        hidden = true,
        flag_update = true,

        header = "header \\N ----------------------------------------------",
        list = {},
        selected = 1,

        keybinds = {
            {'DOWN', 'scroll_down', function() vars:scroll_down() end, {repeatable = true}},
            {'UP', 'scroll_up', function() vars:scroll_up() end, {repeatable = true}},
            {'PGDWN', 'move_pagedown', function() vars:move_pagedown() end, {}},
            {'PGUP', 'move_pageup', function() vars:move_pageup() end, {}},
            {'HOME', 'move_begin', function() vars:move_begin() end, {}},
            {'END', 'move_end', function() vars:move_end() end, {}},
            {'ESC', 'close_browser', function() vars:close() end, {}}
        }
    }
    return setmetatable(vars, metatable)
end
-- scroll-list.lua SECTION END

-- track-select.lua SECTION BEGIN
local o = {
    -- header of the list
    -- %cursor% and %total% to be used to display the cursor position and the total number of lists
    header = "Track List [%cursor%/%total%]\\N ------------------------------------",
    --list ass style overrides inside curly brackets
    --these styles will be used for the whole list. so you need to reset them for every line
    --read http://docs.aegisub.org/3.2/ASS_Tags/ for reference of tags
    global_style = [[]],
    header_style = [[{\q2\fs30\c&00ccff&}]],
    list_style = [[{\q2\fs20\c&Hffffff&}]],
    wrapper_style = [[{\c&00ccff&\fs16}]],
    cursor_style = [[{\c&00ccff&}]],
    selected_style = [[{\c&Hfce788&}]],
    active_style = [[{\c&H33ff66&}]],
    cursor = [[➤\h]],
    indent = [[\h\h\h\h]],
    --amount of entries to show before slicing. Optimal value depends on font/video size etc.
    num_entries = 16,
    --slice long filenames, and how many chars to show
    slice_longfilenames_amount = 100,
    -- wrap the cursor around the top and bottom of the list
    wrap = true,
    -- set dynamic keybinds to bind when the list is open
    key_move_begin = "HOME",
    key_move_end = "END",
    key_move_pageup = "PGUP",
    key_move_pagedown = "PGDWN",
    key_scroll_down = "DOWN WHEEL_DOWN",
    key_scroll_up = "UP WHEEL_UP",
    key_select_track = "ENTER MBTN_LEFT",
    key_reload_track = "R r MBTN_MID",
    key_remove_track = "DEL BS",
    key_close_browser = "ESC MBTN_RIGHT",
}

opts.read_options(o)

local list = scroll_list:new()
local listDest = nil

--modifying the list settings
local original_open = list.open
list.header = o.header
list.cursor = o.cursor
list.indent = o.indent
list.wrap = o.wrap
list.num_entries = o.num_entries
list.global_style = o.global_style
list.header_style = o.header_style
list.list_style = o.list_style
list.wrapper_style = o.wrapper_style
list.cursor_style = o.cursor_style
list.selected_style = o.selected_style

--escape header specifies the format
--display the cursor position and the total number of lists in the header
function list:format_header_string(str)
    if #list.list > 0 then
        str = str:gsub("%%(%a+)%%", { cursor = list.selected, total = #list.list })
    else str = str:gsub("%[.*%]", "") end
    return str
end

local function is_empty(input)
    if input == nil or input == "" then
        return true
    end
end

----- string
local function replace(str, what, with)
    if is_empty(str) then return "" end
    if is_empty(what) then return str end
    if with == nil then with = "" end
    what = string.gsub(what, "[%(%)%.%+%-%*%?%[%]%^%$%%]", "%%%1")
    with = string.gsub(with, "[%%]", "%%%%")
    return string.gsub(str, what, with)
end

local function esc_for_title(str)
    str = str:gsub('^[_%.%-%s]*', '')
            :gsub('%.([^%.]+)$', '')
    return str
end

local function esc_for_codec(str)
    if str:find("MPEG2") then str = "MPEG2"
    elseif str:find("DVVIDEO") then str = "DV"
    elseif str:find("PCM") then str = "PCM"
    elseif str:find("PGS") then str = "PGS"
    elseif str:find("SUBRIP") then str = "SRT"
    elseif str:find("VTT") then str = "VTT"
    elseif str:find("DVD_SUB") then str = "VOB_SUB"
    elseif str:find("DVB_SUB") then str = "DVB_SUB"
    elseif str:find("DVB_TELE") then str = "TELETEXT"
    elseif str:find("ARIB") then str = "ARIB"
    end
    return str
end

local function getTracks(dest)
    local tracksCount = propNative("track-list/count")
    local trackCountVal = {}

    if not (tracksCount < 1) then
        for i = 0, (tracksCount - 1), 1 do
            local trackType = propNative("track-list/" .. i .. "/type")
            if trackType == dest or (trackType == "sub" and dest == "sub2") then
                table.insert(trackCountVal, i)
            end
        end
    end

    return trackCountVal
end

local function isTrackSelected(trackId, dest)
    local selectedId = propNative("current-tracks/" .. dest .. "/id")
    return selectedId == trackId
end

local function isTrackDisabled(trackId, dest)
    return (dest == "sub2" and isTrackSelected(trackId, "sub")) or (dest == "sub" and isTrackSelected(trackId, "sub2"))
end

local function getTrackTitle(trackId, dest)
    local trackTitle = propNative("track-list/" .. trackId .. "/title")
    local trackLang = propNative("track-list/" .. trackId .. "/lang")
    local trackCodec = propNative("track-list/" .. trackId .. "/codec"):upper()
    local trackDefault = propNative("track-list/" .. trackId .. "/default")
    local trackForced = propNative("track-list/" .. trackId .. "/forced")
    local trackExternal = propNative("track-list/" .. trackId .. "/external")
    local filename = propNative("filename/no-ext")

    if trackCodec then trackCodec = esc_for_codec(trackCodec) end
    if trackTitle then trackTitle = replace(trackTitle, filename, "") end
    if trackExternal then trackTitle = esc_for_title(trackTitle) end
    if trackTitle and trackTitle:len() > o.slice_longfilenames_amount + 5 then
        trackTitle = trackTitle:sub(1, o.slice_longfilenames_amount) .. " ..."
    end

    if dest == "video" then
        local trackImage = propNative("track-list/" .. trackId .. "/image")
        local trackwh = propNative("track-list/" .. trackId .. "/demux-w") ..
            "x" .. propNative("track-list/" .. trackId .. "/demux-h")
        local trackFps = string.format("%.3f", propNative("track-list/" .. trackId .. "/demux-fps"))
        if trackTitle and not trackImage then TrackTitle = trackTitle ..
            ", [" .. trackCodec .. "]" .. ", " .. trackwh .. ", " .. trackFps .. " FPS"
        elseif trackTitle then TrackTitle = trackTitle .. ", [" .. trackCodec .. "]" .. ", " .. trackwh
        elseif trackImage then TrackTitle = "[" .. trackCodec .. "]" .. ", " .. trackwh
        elseif trackFps then TrackTitle = "[" .. trackCodec .. "]" .. ", " .. trackwh .. ", " .. trackFps .. " FPS"
        end
    end

    if dest == "audio" then
        -- local trackBitrate = propNative("track-list/" .. trackId .. "/demux-bitrate")/1000
        local trackSamplerate = string.format("%.1f", propNative("track-list/" .. trackId .. "/demux-samplerate") / 1000)
        local trackChannels = propNative("track-list/" .. trackId .. "/demux-channel-count")
        if trackTitle and trackLang then TrackTitle = trackTitle .. ", " .. trackLang ..
            ", [" .. trackCodec .. "]" .. ", " .. trackChannels .. " ch" .. ", " .. trackSamplerate .. " kHz"
        elseif trackTitle then TrackTitle = trackTitle ..
            ", [" .. trackCodec .. "]" .. ", " .. trackChannels .. " ch" .. ", " .. trackSamplerate .. " kHz"
        elseif trackLang then TrackTitle = trackLang ..
            ", [" .. trackCodec .. "]" .. ", " .. trackChannels .. " ch" .. ", " .. trackSamplerate .. " kHz"
        elseif trackChannels then TrackTitle = 
            "[" .. trackCodec .. "]" .. ", " .. trackChannels .. " ch" .. ", " .. trackSamplerate .. " kHz"
        end
    end

    if dest == "sub" or dest == "sub2" then
        if trackTitle and trackLang then TrackTitle = trackTitle .. ", " .. trackLang .. ", [" .. trackCodec .. "]"
        elseif trackTitle then TrackTitle = trackTitle .. ", [" .. trackCodec .. "]"
        elseif trackLang then TrackTitle = trackLang .. ", [" .. trackCodec .. "]"
        elseif trackCodec then TrackTitle = "[" .. trackCodec .. "]"
        end
    end

    if trackForced then TrackTitle = TrackTitle .. ", " .. "Forced" end
    if trackDefault then TrackTitle = TrackTitle .. ", " .. "Default" end
    if trackExternal then TrackTitle = TrackTitle .. ", " .. "External" end

    return list.ass_escape(TrackTitle)
end

local function updateTrackList(listTitle, trackDest, formatter)
    list.header = listTitle .. ": " .. o.header
    list.list = {
        {
            id = nil,
            index = nil,
            disabled = false,
            ass = "○ None"
        }
    }

    if isTrackSelected(nil, trackDest) then
        list.selected = 1
        list[1].ass = "● None"
        list[1].style = o.active_style
    end

    local tracks = getTracks(trackDest)
    if #tracks ~= 0 then
        for i = 1, #tracks, 1 do
            local trackIndex = tracks[i]
            local trackId = propNative("track-list/" .. trackIndex .. "/id")
            local title = formatter(trackIndex, trackDest)
            local isDisabled = isTrackDisabled(trackId, trackDest)

            local listItem = {
                id = trackId,
                index = trackIndex,
                disabled = isDisabled
            }
            if isTrackSelected(trackId, trackDest) then
                list.selected = i + 1
                listItem.style = o.active_style
                listItem.ass = "● " .. title
            elseif isDisabled then
                listItem.style = [[{\c&Hff6666&}]]
                listItem.ass = "○ " .. title
            else
                listItem.ass = "○ " .. title
            end
            table.insert(list.list, listItem)
        end
    end

    list:update()
end

local function updateVideoTrackList()
    updateTrackList("Video", "video", getTrackTitle)
end

local function updateAudioTrackList()
    updateTrackList("Audio", "audio", getTrackTitle)
end

local function updateSubTrackList()
    updateTrackList("Subtitle", "sub", getTrackTitle)
end

-- Secondary subtitle track-list menu
local function updateSecondarySubTrackList()
    updateTrackList("Secondary Subtitle", "sub2", getTrackTitle)
end

local function selectTrack()
    local selected = list.list[list.selected]
    if selected then
        if selected.disabled then return end

        local trackId = selected.id
        if trackId == nil then trackId = "no" end

        if listDest == "video" then
            mp.set_property_native("vid", trackId)
        elseif listDest == "audio" then
            mp.set_property_native("aid", trackId)
        elseif listDest == "sub" then
            mp.set_property_native("sid", trackId)
        elseif listDest == "sub2" then
            mp.set_property_native("secondary-sid", trackId)
        end
    end
end

local function reloadTrack()
    local selected = list.list[list.selected]
    if selected then
        if selected.disabled then return end

        local trackId = selected.id
        if trackId == nil then return end

        if listDest == "video" then
            mp.commandv("video-reload", trackId)
        elseif listDest == "audio" then
            mp.commandv("audio-reload", trackId)
        elseif listDest == "sub" then
            mp.commandv("sub-reload", trackId)
        end
    end
end

local function removeTrack()
    local selected = list.list[list.selected]
    if selected then
        if selected.disabled then return end

        local trackId = selected.id
        if trackId == nil then return end

        if listDest == "video" then
            mp.commandv("video-remove", trackId)
        elseif listDest == "audio" then
            mp.commandv("audio-remove", trackId)
        elseif listDest == "sub" then
            mp.commandv("sub-remove", trackId)
        end
    end
end

--dynamic keybinds to bind when the list is open
list.keybinds = {}

local function add_keys(keys, name, fn, flags)
    local i = 1
    for key in keys:gmatch("%S+") do
        table.insert(list.keybinds, { key, name .. i, fn, flags })
        i = i + 1
    end
end

add_keys(o.key_scroll_down, 'scroll_down', function() list:scroll_down() end, { repeatable = true })
add_keys(o.key_scroll_up, 'scroll_up', function() list:scroll_up() end, { repeatable = true })
add_keys(o.key_move_pageup, 'move_pageup', function() list:move_pageup() end, {})
add_keys(o.key_move_pagedown, 'move_pagedown', function() list:move_pagedown() end, {})
add_keys(o.key_move_begin, 'move_begin', function() list:move_begin() end, {})
add_keys(o.key_move_end, 'move_end', function() list:move_end() end, {})
add_keys(o.key_select_track, 'select_track', selectTrack, {})
add_keys(o.key_reload_track, 'reload_track', reloadTrack, {})
add_keys(o.key_remove_track, 'remove_track', removeTrack, {})
add_keys(o.key_close_browser, 'close_browser', function() list:close() end, {})

local function setTrackChangeHandler(property, func)
    mp.unobserve_property(updateVideoTrackList)
    mp.unobserve_property(updateAudioTrackList)
    mp.unobserve_property(updateSubTrackList)
    mp.unobserve_property(updateSecondarySubTrackList)
    if func ~= nil then
        mp.observe_property("track-list/count", "number", func)
        mp.observe_property(property, "string", func)
    end
end

local function toggleListDelayed(dest)
    listDest = dest
    mp.add_timeout(0.1, function()
        list:toggle()
    end)
end

local function openVideoTrackList()
    list:close()
    setTrackChangeHandler("vid", updateVideoTrackList)
    toggleListDelayed("video")
end

local function openAudioTrackList()
    list:close()
    setTrackChangeHandler("aid", updateAudioTrackList)
    toggleListDelayed("audio")
end

local function openSubTrackList()
    list:close()
    setTrackChangeHandler("sid", updateSubTrackList)
    toggleListDelayed("sub")
end

local function openSecondarySubTrackList()
    list:close()
    setTrackChangeHandler("secondary-sid", updateSecondarySubTrackList)
    toggleListDelayed("sub2")
end

mp.add_key_binding(nil,"toggle-vidtrack-browser", openVideoTrackList)
mp.add_key_binding("ALT+SHARP", "toggle-audtrack-browser", openAudioTrackList)
mp.add_key_binding("ALT+j", "toggle-subtrack-browser", openSubTrackList)
mp.add_key_binding("ALT+J", "toggle-secondary-subtrack-browser", openSecondarySubTrackList)

mp.register_event("end-file", function()
    setTrackChangeHandler(nil, nil)
end)
-- track-select.lua SECTION END
