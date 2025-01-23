local gears = require("gears")
local awful = require("awful")

local _M = {}

function _M.get()
    local taglist_button = gears.table.join(
        awful.button({}, 1, function(t) t:view_only() end),
        awful.button({ RC.vars.modkey }, 1, function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end),
        awful.button({}, 3, awful.tag.viewtoggle),
        awful.button({ RC.vars.modkey }, 3, function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end),
        awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
        awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
    )
    return taglist_button
end


return setmetatable({}, {
    __call = function(_, ...) return _M.get(...) end
})
