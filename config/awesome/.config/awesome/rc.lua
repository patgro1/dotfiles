-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local awful = require("awful")
require("awful.autofocus")
-- Theme handling library
local beautiful = require("beautiful")

local config_path = awful.util.getdir("config")


-- Error handling
require("main.error-handling")

RC = {}
RC.vars = require("main.user-variables")

local main = {
    layouts = require("main.layouts"),
    tags = require("main.tags"),
    menu = require("main.menu"),
    rules = require("main.rules")
}

-- NOTE: buttons are for mouse, keys for keyboard shortcuts
local bindings = {
    globalbuttons = require("bindings.globalbuttons"),
    clientbuttons = require("bindings.clientbuttons"),
    globalkeys = require("bindings.globalkeys"),
    clientkeys = require("bindings.clientkeys"),
    bindtotags = require("bindings.bindtotags")
}

RC.layouts = main.layouts()
RC.tags = main.tags()
RC.menu = main.menu()
RC.globalkeys = bindings.globalkeys()
RC.globalkeys = bindings.bindtotags(RC.globalkeys)

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
local theme_rc = config_path .. "themes/" .. RC.vars.theme .. "/theme.lua"
beautiful.init(theme_rc)

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = main.layouts()

RC.mainmenu = awful.menu({ items = RC.menu })

RC.launcher = awful.widget.launcher({
    image = beautiful.awesome_icon, menu = RC.mymainmenu
})

-- {{{ Mouse bindings
root.buttons(bindings.globalbuttons())
-- }}}

-- Set keys
root.keys(RC.globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = main.rules(bindings.clientkeys(), bindings.clientbuttons())
-- }}}


require("main.signals")
require("deco.statusbar")

do
    local autorun_apps = {
        "picom"
    }

    for _,i in pairs(autorun_apps) do
        awful.spawn.single_instance(i, awful.rules.rules)
    end
end
