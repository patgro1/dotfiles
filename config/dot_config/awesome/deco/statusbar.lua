local gears            = require("gears")
local awful            = require("awful")
local wibox            = require("wibox")
local lain             = require("lain")
local beautiful        = require("beautiful")
local dpi              = require("beautiful.xresources").apply_dpi

local markup           = lain.util.markup
local gray             = "#94928F"

local my_table         = awful.util.table or gears.table -- 4.{0,1} compatibility

local deco             = {
    wallpaper = require("deco.wallpaper"),
    taglist = require("deco.taglist"),
    tasklist = require("deco.tasklist"),
}

local theme            = beautiful.get()

-- local battery          = require("deco.widgets.battery")
local spotify          = require("deco.widgets.spotify")

local taglist_buttons  = deco.taglist()
local tasklist_buttons = deco.tasklist()

local _M               = {}

-- Keyboard map indicator and switcher
local mykeyboardlayout = awful.widget.keyboardlayout()
-- Create a textclock widget
local mytextclock      = wibox.widget.textclock(" %H:%M:%S ")
mytextclock.refresh    = 1
mytextclock.font       = theme.font

-- Calendar
theme.cal              = lain.widget.cal({
    attach_to = { mytextclock },
    notification_preset = {
        font = "Terminus 11",
        fg = theme.fg_normal,
        bg = theme.bg_normal
    }
})
local spotify_w = spotify({
    font = 'Ubuntu Mono 9',
    play_icon = '/usr/share/icons/breeze/actions/32/media-playback-start.svg',
    pause_icon = '/usr/share/icons/breeze/actions/32/media-playback-pause.svg',
    dim_when_paused = true,
    dim_opacity = 0.5,
    max_length = -1,
    show_tooltip = false,
    -- sp_bin = gears.filesystem.get_configuration_dir() .. 'scripts/sp'
})

-- Media Player
theme.mpd              = lain.widget.mpd({
    settings = function()
        artist = mpd_now.artist
        title = mpd_now.title

        if mpd_now.state == "pause" then
            artist = "mpd "
            title = "paused "
        elseif mpd_now.state == "stop" then
            artist = ""
            title = ""
        end
        widget:set_markup(markup.font(theme.font, markup(gray, artist) .. title))
    end
})

theme.volume           = lain.widget.alsa({
    settings = function()
        header = "Vol "
        vlevel = volume_now.level

        if volume_now.status == "off" then
            vlevel = vlevel .. "M "
        else
            vlevel = vlevel .. " "
        end
        widget:set_markup(markup.font(theme.font, markup(gray, header) .. vlevel .. " "))
    end
})


-- CPU widget
local cpu     = lain.widget.sysload({
    settings = function()
        widget:set_markup(markup.font(theme.font, markup(gray, " Cpu ") .. load_1 .. " "))
    end
})

local mem     = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(theme.font, markup(gray, " Mem ") .. mem_now.perc .. "% "))
    end
})

-- local fs = lain.widget.fs({
--     partition = "/home",
--     notification_preset = { fg = theme.fg_normal, bg = theme.bg_normal, font = theme.font }
-- })

local battery = lain.widget.bat({
    settings = function()
        local perc = bat_now.perc
        if bat_now.ac_status == 1 then
            perc = perc .. " AC"
        end
        widget:set_markup(markup.font(theme.font, markup(gray, " Bat ") .. perc .. " "))
    end
})

-- Separators
local first   = wibox.widget.textbox(markup.font("Terminus 4", " "))
local spr     = wibox.widget.textbox(' ')

awful.screen.connect_for_each_screen(function(s)
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- Wallpaper
    set_wallpaper(s)

    -- Tags
    -- awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({}, 1, function() awful.layout.inc(1) end),
        awful.button({}, 3, function() awful.layout.inc(-1) end),
        awful.button({}, 4, function() awful.layout.inc(1) end),
        awful.button({}, 5, function() awful.layout.inc(-1) end)))
    --     -- Textual layoutbox
    -- s.mytxtlayoutbox = wibox.widget.textbox(theme["layout_txt_" .. awful.layout.getname(awful.layout.get(s))])
    -- awful.tag.attached_connect_signal(s, "property::selected", function() update_txt_layoutbox(s) end)
    -- awful.tag.attached_connect_signal(s, "property::layout", function() update_txt_layoutbox(s) end)
    -- s.mytxtlayoutbox:buttons(my_table.join(
    --     awful.button({}, 1, function() awful.layout.inc(1) end),
    --     awful.button({}, 2, function() awful.layout.set(awful.layout.layouts[1]) end),
    --     awful.button({}, 3, function() awful.layout.inc(-1) end),
    --     awful.button({}, 4, function() awful.layout.inc(1) end),
    --     awful.button({}, 5, function() awful.layout.inc(-1) end)))

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(18) })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            first,
            s.mytaglist,
            spr,
            s.mylayoutbox,
            s.mypromptbox,
            spr,
        },
        s.mytasklist, -- Middle widget
        {             -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            spr,
            spotify_w,
            spr,
            cpu.widget,
            mem.widget,
            battery.widget,
            theme.volume.widget,
            mytextclock,
        },
    }
end
)
