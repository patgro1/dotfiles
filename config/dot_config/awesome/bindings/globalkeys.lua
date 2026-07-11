local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

local menubar = require("menubar")
menubar.utils.terminal = RC.vars.terminal -- Set the terminal for applications that require it

local _M = {}

local rofi_dir = os.getenv("HOME") .. "/.config/rofi/scripts/"

-- OSD-style feedback: one notification per category, replaced in place
-- instead of stacking, so spamming a key doesn't flood the screen.
local osd_ids = {}
local function osd_notify(category, text)
    local n = naughty.notify({
        title = category,
        text = text,
        timeout = 1.5,
        replaces_id = osd_ids[category],
    })
    osd_ids[category] = n.id
end

function _M.get()
    local global_keys = gears.table.join(
        awful.key({ RC.vars.modkey, }, "s", hotkeys_popup.show_help,
            { description = "show help", group = "awesome" }),
        awful.key({ RC.vars.modkey, }, "Left", awful.tag.viewprev,
            { description = "view previous", group = "tag" }),
        awful.key({ RC.vars.modkey, }, "Right", awful.tag.viewnext,
            { description = "view next", group = "tag" }),
        awful.key({ RC.vars.modkey, }, "Escape", awful.tag.history.restore,
            { description = "go back", group = "tag" }),

        awful.key({ RC.vars.modkey, }, "h",
            function()
                awful.client.focus.global_bydirection("left")
            end,
            { description = "focus client on left", group = "client" }
        ),
        awful.key({ RC.vars.modkey, }, "j",
            function()
                awful.client.focus.global_bydirection("down")
            end,
            { description = "focus client down", group = "client" }
        ),
        awful.key({ RC.vars.modkey, }, "k",
            function()
                awful.client.focus.global_bydirection("up")
            end,
            { description = "focus client up", group = "client" }
        ),
        awful.key({ RC.vars.modkey, }, "l",
            function()
                awful.client.focus.global_bydirection("right")
            end,
            { description = "focus client right", group = "client" }
        ),

        -- Layout manipulation
        awful.key({ RC.vars.modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end,
            { description = "swap with next client by index", group = "client" }),
        awful.key({ RC.vars.modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end,
            { description = "swap with previous client by index", group = "client" }),
        awful.key({ RC.vars.modkey, "Control" }, "h", function() awful.screen.focus_bydirection("left") end,
            { description = "focus the next screen", group = "screen" }),
        awful.key({ RC.vars.modkey, "Control" }, "j", function() awful.screen.focus_bydirection("down") end,
            { description = "focus the next screen", group = "screen" }),
        awful.key({ RC.vars.modkey, "Control" }, "k", function() awful.screen.focus_bydirection("up") end,
            { description = "focus the previous screen", group = "screen" }),
        awful.key({ RC.vars.modkey, "Control" }, "l", function() awful.screen.focus_bydirection("right") end,
            { description = "focus the previous screen", group = "screen" }),
        awful.key({ RC.vars.modkey, }, "u", awful.client.urgent.jumpto,
            { description = "jump to urgent client", group = "client" }),
        awful.key({ RC.vars.modkey, }, "Tab",
            function()
                awful.client.focus.history.previous()
                if client.focus then
                    client.focus:raise()
                end
            end,
            { description = "go back", group = "client" }),

        -- Standard program
        awful.key({ RC.vars.modkey, }, "Return", function() awful.spawn(RC.vars.terminal) end,
            { description = "open a terminal", group = "launcher" }),
        awful.key({ RC.vars.modkey, "Control" }, "r", awesome.restart,
            { description = "reload awesome", group = "awesome" }),
        awful.key({ RC.vars.modkey, "Shift" }, "e", awesome.quit,
            { description = "quit awesome", group = "awesome" }),
        awful.key({ RC.vars.modkey, "Shift" }, "x", function() awful.spawn("xkill") end,
            { description = "kill an unresponsive window", group = "awesome" }),
        awful.key({ RC.vars.modkey, }, "bracketright", function() awful.tag.incmwfact(0.05) end,
            { description = "increase master width factor", group = "layout" }),
        awful.key({ RC.vars.modkey, }, "bracketleft", function() awful.tag.incmwfact(-0.05) end,
            { description = "decrease master width factor", group = "layout" }),
        awful.key({ RC.vars.modkey, "Control" }, "bracketright", function() awful.tag.incnmaster(1, nil, true) end,
            { description = "increase the number of master clients", group = "layout" }),
        awful.key({ RC.vars.modkey, "Control" }, "bracketleft", function() awful.tag.incnmaster(-1, nil, true) end,
            { description = "decrease the number of master clients", group = "layout" }),
        awful.key({ RC.vars.modkey, }, "space", function() awful.layout.inc(1) end,
            { description = "select next", group = "layout" }),
        awful.key({ RC.vars.modkey, "Shift" }, "space", function() awful.layout.inc(-1) end,
            { description = "select previous", group = "layout" }),

        -- rofi launcher
        awful.key({ RC.vars.modkey }, "d", function() awful.spawn(rofi_dir .. "launcher_t2") end,
            { description = "launch application", group = "launcher" }),
        awful.key({ RC.vars.modkey }, "p", function() awful.spawn(rofi_dir .. "powermenu_t2") end,
            { description = "power menu", group = "launcher" }),
        awful.key({ RC.vars.modkey }, "b", function() awful.spawn(rofi_dir .. "bluetooth") end,
            { description = "bluetooth menu", group = "launcher" }),
        awful.key({ RC.vars.modkey }, "w", function() awful.spawn(rofi_dir .. "wifi") end,
            { description = "wifi menu", group = "launcher" }),
        awful.key({ "Control", "Mod1" }, "l", function() awful.spawn(os.getenv("HOME") .. "/.local/scripts/lock.sh") end,
            { description = "lock screen", group = "launcher" }),

        -- Volume keys
        awful.key({}, "XF86AudioRaiseVolume", function()
            awful.spawn.easy_async("amixer -q set Master 5%+", function()
                beautiful.volume.update()
                awful.spawn.easy_async("amixer get Master", function(stdout)
                    local level, status = stdout:match("([%d]+)%%.*%[([%l]*)")
                    osd_notify("Volume", status == "off" and "Muted" or (level .. "%"))
                end)
            end)
        end, { description = "raise volume", group = "launcher" }),
        awful.key({}, "XF86AudioLowerVolume", function()
            awful.spawn.easy_async("amixer -q set Master 5%-", function()
                beautiful.volume.update()
                awful.spawn.easy_async("amixer get Master", function(stdout)
                    local level, status = stdout:match("([%d]+)%%.*%[([%l]*)")
                    osd_notify("Volume", status == "off" and "Muted" or (level .. "%"))
                end)
            end)
        end, { description = "lower volume", group = "launcher" }),
        awful.key({}, "XF86AudioMute", function()
            awful.spawn.easy_async("amixer -q set Master toggle", function()
                beautiful.volume.update()
                awful.spawn.easy_async("amixer get Master", function(stdout)
                    local level, status = stdout:match("([%d]+)%%.*%[([%l]*)")
                    osd_notify("Volume", status == "off" and "Muted" or (level .. "%"))
                end)
            end)
        end, { description = "toggle mute", group = "launcher" }),

        -- Media keys
        awful.key({}, "XF86AudioPlay", function() awful.spawn("playerctl play-pause") end,
            { description = "play/pause", group = "launcher" }),
        awful.key({}, "XF86AudioNext", function() awful.spawn("playerctl next") end,
            { description = "next track", group = "launcher" }),
        awful.key({}, "XF86AudioPrev", function() awful.spawn("playerctl previous") end,
            { description = "previous track", group = "launcher" }),

        -- Screenshots
        awful.key({}, "Print", function() awful.spawn("flameshot full -c") end,
            { description = "screenshot to clipboard", group = "launcher" }),
        awful.key({ "Shift" }, "Print", function()
            awful.spawn("flameshot full -c -p " .. os.getenv("HOME") .. "/Pictures/Screenshots")
        end, { description = "screenshot to clipboard + file", group = "launcher" }),
        awful.key({}, "XF86Launch2", function() awful.spawn("flameshot gui") end,
            { description = "snipping tool (region select)", group = "launcher" }),

        -- Brightness keys
        awful.key({}, "XF86MonBrightnessUp", function()
            awful.spawn.easy_async("brightnessctl set +5%", function()
                awful.spawn.easy_async("brightnessctl -m", function(stdout)
                    local pct = stdout:match(",(%d+)%%,")
                    if pct then osd_notify("Brightness", pct .. "%") end
                end)
            end)
        end, { description = "increase brightness", group = "launcher" }),
        awful.key({}, "XF86MonBrightnessDown", function()
            awful.spawn.easy_async("brightnessctl set 5%-", function()
                awful.spawn.easy_async("brightnessctl -m", function(stdout)
                    local pct = stdout:match(",(%d+)%%,")
                    if pct then osd_notify("Brightness", pct .. "%") end
                end)
            end)
        end, { description = "decrease brightness", group = "launcher" }),


        awful.key({ RC.vars.modkey, "Control" }, "n",
            function()
                local c = awful.client.restore()
                -- Focus restored client
                if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", { raise = true }
                    )
                end
            end,
            { description = "restore minimized", group = "client" }),

        -- Prompt
        awful.key({ RC.vars.modkey }, "r", function() awful.screen.focused().mypromptbox:run() end,
            { description = "run prompt", group = "launcher" }),

        awful.key({ RC.vars.modkey }, "x",
            function()
                awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                }
            end,
            { description = "lua execute prompt", group = "awesome" })
    )
    return global_keys
end

return setmetatable(
    {},
    { __call = function(_, ...) return _M.get(...) end }
)
