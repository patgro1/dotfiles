local beautiful = require("beautiful")

local M = {}
local _M = {}

local terminal = RC.vars.terminal
local editor = RC.vars.editor

local editor_cmd = terminal .. " -e " .. editor

M.awesome = {
    -- {{{ Menu
    -- Create a launcher widget and a main menu
    { "hotkeys",     function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "manual",      RC.vars.terminal .. " -e man awesome" },
    { "edit config", editor_cmd .. " " .. awesome.conffile },
    { "restart",     awesome.restart },
    { "quit",        function() awesome.quit() end },
}

M.favorites = {
    { "vivaldi", "vivaldi" },
    { "spotify", "spotify" },
    { "zoom",    "zoom" },
}

function _M.get()
    local menu_items = {
        { "awesome",       M.awesome,       beautiful.awesome_subicon },
        { "open terminal", RC.vars.terminal },
        { "favorites",     M.favorites }
    }

    return menu_items
end

return setmetatable(
    {},
    { __call = function(_, ...) return _M.get(...) end }
)
