-------------------------------------------------
-- Spotify Widget for Awesome Window Manager
-- Shows currently playing song via playerctl (MPRIS)
-------------------------------------------------

local awful = require("awful")
local wibox = require("wibox")
local watch = require("awful.widget.watch")

local function ellipsize(text, length)
    -- utf8 only available in Lua 5.3+
    if utf8 == nil then
        return text:sub(0, length)
    end
    return (utf8.len(text) > length and length > 0)
        and text:sub(0, utf8.offset(text, length - 2) - 1) .. '...'
        or text
end

local spotify_widget = {}

local function worker(user_args)
    local args = user_args or {}

    local play_icon = args.play_icon or '/usr/share/icons/Humanity/actions/24/media-playback-start.svg'
    local pause_icon = args.pause_icon or '/usr/share/icons/Humanity/actions/24/media-playback-pause.svg'
    local font = args.font or 'Play 9'
    local dim_when_paused = args.dim_when_paused == nil and false or args.dim_when_paused
    local dim_opacity = args.dim_opacity or 0.2
    local max_length = args.max_length or 15
    local show_tooltip = args.show_tooltip == nil and true or args.show_tooltip
    local timeout = args.timeout or 1
    local player = args.player or 'spotify'

    local PLAYERCTL = 'playerctl -p ' .. player
    local GET_STATUS_CMD = PLAYERCTL .. ' status'
    local GET_METADATA_CMD = PLAYERCTL .. ' metadata --format {{album}}|||{{artist}}|||{{title}}'
    local PLAY_PAUSE_CMD = PLAYERCTL .. ' play-pause'
    local NEXT_SONG_CMD = PLAYERCTL .. ' next'
    local PREVIOUS_SONG_CMD = PLAYERCTL .. ' previous'

    local cur_artist = ''
    local cur_title = ''
    local cur_album = ''

    spotify_widget = wibox.widget {
        {
            id = "icon",
            widget = wibox.widget.imagebox,
            forced_width = args.icon_size or 14,
            forced_height = args.icon_size or 14,
        },
        {
            id = 'artistw',
            font = font,
            widget = wibox.widget.textbox,
        },
        {
            layout = wibox.container.scroll.horizontal,
            max_size = 100,
            step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
            speed = 40,
            {
                id = 'titlew',
                font = font,
                widget = wibox.widget.textbox
            }
        },
        layout = wibox.layout.fixed.horizontal,
        spacing = 4,
        set_status = function(self, is_playing)
            self:get_children_by_id('icon')[1]:set_image(is_playing and play_icon or pause_icon)
            if dim_when_paused then
                self:get_children_by_id('icon')[1]:set_opacity(is_playing and 1 or dim_opacity)

                self:get_children_by_id('titlew')[1]:set_opacity(is_playing and 1 or dim_opacity)
                self:get_children_by_id('titlew')[1]:emit_signal('widget::redraw_needed')

                self:get_children_by_id('artistw')[1]:set_opacity(is_playing and 1 or dim_opacity)
                self:get_children_by_id('artistw')[1]:emit_signal('widget::redraw_needed')
            end
        end,
        set_text = function(self, artist, song)
            local artist_to_display = ellipsize(artist, max_length)
            if self:get_children_by_id('artistw')[1]:get_markup() ~= artist_to_display then
                self:get_children_by_id('artistw')[1]:set_markup(artist_to_display)
            end
            local title_to_display = ellipsize(song, max_length)
            if self:get_children_by_id('titlew')[1]:get_markup() ~= title_to_display then
                self:get_children_by_id('titlew')[1]:set_markup(title_to_display)
            end
        end
    }

    local update_widget_icon = function(widget, stdout, _, _, exitcode)
        stdout = string.gsub(stdout, "\n", "")
        widget:set_status(exitcode == 0 and stdout == 'Playing')
    end

    local update_widget_text = function(widget, stdout, _, _, exitcode)
        if exitcode ~= 0 or stdout == '' then
            widget:set_text('', '')
            widget:set_visible(false)
            return
        end

        local escaped = string.gsub(stdout, "&", '&amp;')
        local album, artist, title = string.match(escaped, '^(.-)|||(.-)|||(.-)\n?$')

        if album ~= nil and title ~= nil and artist ~= nil then
            cur_artist = artist
            cur_title = title
            cur_album = album

            widget:set_text(artist, title)
            widget:set_visible(true)
        end
    end

    watch(GET_STATUS_CMD, timeout, update_widget_icon, spotify_widget)
    watch(GET_METADATA_CMD, timeout, update_widget_text, spotify_widget)

    --- Adds mouse controls to the widget:
    --  - left click - play/pause
    --  - scroll up - play next song
    --  - scroll down - play previous song
    spotify_widget:connect_signal("button::press", function(_, _, _, button)
        if (button == 1) then
            awful.spawn(PLAY_PAUSE_CMD, false)    -- left click
        elseif (button == 4) then
            awful.spawn(NEXT_SONG_CMD, false)     -- scroll up
        elseif (button == 5) then
            awful.spawn(PREVIOUS_SONG_CMD, false) -- scroll down
        end
        awful.spawn.easy_async(GET_STATUS_CMD, function(stdout, stderr, exitreason, exitcode)
            update_widget_icon(spotify_widget, stdout, stderr, exitreason, exitcode)
        end)
    end)


    if show_tooltip then
        local spotify_tooltip = awful.tooltip {
            mode = 'outside',
            preferred_positions = { 'bottom' },
        }

        spotify_tooltip:add_to_object(spotify_widget)

        spotify_widget:connect_signal('mouse::enter', function()
            spotify_tooltip.markup = '<b>Album</b>: ' .. cur_album
                .. '\n<b>Artist</b>: ' .. cur_artist
                .. '\n<b>Song</b>: ' .. cur_title
        end)
    end

    return spotify_widget
end

return setmetatable(spotify_widget, {
    __call = function(_, ...)
        return worker(...)
    end
})
