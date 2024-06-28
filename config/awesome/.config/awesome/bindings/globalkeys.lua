local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

local menubar = require("menubar")
menubar.utils.terminal = RC.vars.terminal -- Set the terminal for applications that require it

local _M = {}

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

        awful.key({ RC.vars.modkey, }, "j",
            function()
                awful.client.focus.byidx(1)
            end,
            { description = "focus next by index", group = "client" }
        ),
        awful.key({ RC.vars.modkey, }, "k",
            function()
                awful.client.focus.byidx(-1)
            end,
            { description = "focus previous by index", group = "client" }
        ),
        awful.key({ RC.vars.modkey, }, "w", function() mymainmenu:show() end,
            { description = "show main menu", group = "awesome" }),

        -- Layout manipulation
        awful.key({ RC.vars.modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end,
            { description = "swap with next client by index", group = "client" }),
        awful.key({ RC.vars.modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end,
            { description = "swap with previous client by index", group = "client" }),
        awful.key({ RC.vars.modkey, "Control" }, "j", function() awful.screen.focus_relative(1) end,
            { description = "focus the next screen", group = "screen" }),
        awful.key({ RC.vars.modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end,
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
        awful.key({ RC.vars.modkey, "Shift" }, "q", awesome.quit,
            { description = "quit awesome", group = "awesome" }),
        awful.key({ RC.vars.modkey, }, "l", function() awful.tag.incmwfact(0.05) end,
            { description = "increase master width factor", group = "layout" }),
        awful.key({ RC.vars.modkey, }, "h", function() awful.tag.incmwfact(-0.05) end,
            { description = "decrease master width factor", group = "layout" }),
        awful.key({ RC.vars.modkey, "Shift" }, "h", function() awful.tag.incnmaster(1, nil, true) end,
            { description = "increase the number of master clients", group = "layout" }),
        awful.key({ RC.vars.modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1, nil, true) end,
            { description = "decrease the number of master clients", group = "layout" }),
        awful.key({ RC.vars.modkey, "Control" }, "h", function() awful.tag.incncol(1, nil, true) end,
            { description = "increase the number of columns", group = "layout" }),
        awful.key({ RC.vars.modkey, "Control" }, "l", function() awful.tag.incncol(-1, nil, true) end,
            { description = "decrease the number of columns", group = "layout" }),
        awful.key({ RC.vars.modkey, }, "space", function() awful.layout.inc(1) end,
            { description = "select next", group = "layout" }),
        awful.key({ RC.vars.modkey, "Shift" }, "space", function() awful.layout.inc(-1) end,
            { description = "select previous", group = "layout" }),

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
            { description = "lua execute prompt", group = "awesome" }),
        -- Menubar
        awful.key({ RC.vars.modkey }, "p", function() menubar.show() end,
            { description = "show the menubar", group = "launcher" })
    )
    return global_keys
end

return setmetatable(
    {},
    { __call = function(_, ...) return _M.get(...) end }
)
