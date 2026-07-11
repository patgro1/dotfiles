local gears = require("gears")
local awful = require("awful")

local moves = require("utils.moves")

local _M = {}

function _M.get()
    local client_keys = gears.table.join(
        awful.key({ RC.vars.modkey, }, "f",
            function(c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            { description = "toggle fullscreen", group = "client" }),
        awful.key({ RC.vars.modkey, "Shift" }, "h", function(c) moves.move_left_right(c, "left") end,
            { description = "Move client to left", group = "client" }),
        awful.key({ RC.vars.modkey, "Shift" }, "l", function(c) moves.move_left_right(c, "right") end,
            { description = "Move client to left", group = "client" }),
        awful.key({ RC.vars.modkey, "Shift" }, "q", function(c) c:kill() end,
            { description = "close", group = "client" }),
        awful.key({ RC.vars.modkey, "Control" }, "space", awful.client.floating.toggle,
            { description = "toggle floating", group = "client" }),
        awful.key({ RC.vars.modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end,
            { description = "move to master", group = "client" }),
        awful.key({ RC.vars.modkey, }, "o", function(c) c:move_to_screen() end,
            { description = "move to screen", group = "client" }),
        awful.key({ RC.vars.modkey, }, "t", function(c) c.ontop = not c.ontop end,
            { description = "toggle keep on top", group = "client" }),
        awful.key({ RC.vars.modkey, }, "n",
            function(c)
                -- The client currently has the input focus, so it cannot be
                -- minimized, since minimized clients can't have the focus.
                c.minimized = true
            end,
            { description = "minimize", group = "client" }),
        awful.key({ RC.vars.modkey, }, "m",
            function(c)
                c.maximized = not c.maximized
                c:raise()
            end,
            { description = "(un)maximize", group = "client" }),
        awful.key({ RC.vars.modkey, "Control" }, "m",
            function(c)
                c.maximized_vertical = not c.maximized_vertical
                c:raise()
            end,
            { description = "(un)maximize vertically", group = "client" }),
        awful.key({ RC.vars.modkey, "Shift" }, "m",
            function(c)
                c.maximized_horizontal = not c.maximized_horizontal
                c:raise()
            end,
            { description = "(un)maximize horizontally", group = "client" }),

        -- Resize: floating clients move/resize freely, tiled clients adjust
        -- their share of the stack column via incwfact (width isn't
        -- per-client adjustable in the tile layout, only the master ratio,
        -- see the bracket keys above).
        awful.key({ RC.vars.modkey, "Control", "Shift" }, "l", function(c)
            if c.floating then c:relative_move(0, 0, 20, 0) end
        end, { description = "grow width (floating only)", group = "client" }),
        awful.key({ RC.vars.modkey, "Control", "Shift" }, "h", function(c)
            if c.floating then c:relative_move(0, 0, -20, 0) end
        end, { description = "shrink width (floating only)", group = "client" }),
        awful.key({ RC.vars.modkey, "Control", "Shift" }, "j", function(c)
            if c.floating then
                c:relative_move(0, 0, 0, 20)
            else
                awful.client.incwfact(0.05, c)
            end
        end, { description = "grow height", group = "client" }),
        awful.key({ RC.vars.modkey, "Control", "Shift" }, "k", function(c)
            if c.floating then
                c:relative_move(0, 0, 0, -20)
            else
                awful.client.incwfact(-0.05, c)
            end
        end, { description = "shrink height", group = "client" })
    )
    return client_keys
end

return setmetatable(
    {},
    { __call = function(_, ...) return _M.get(...) end }
)
