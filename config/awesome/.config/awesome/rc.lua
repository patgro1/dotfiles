-- awesome_mode: api-level=4:screen=on

-- load luarocks if installed
pcall(require, 'luarocks.loader')

-- load theme
local beautiful = require 'beautiful'
local gears = require 'gears'
local theme_name = "catppuccin"
local theme_path = gears.filesystem.get_configuration_dir() .. "themes/"
local theme = theme_path .. theme_name .. "/theme.lua"
beautiful.init(theme)

-- load key and mouse bindings
require 'bindings'

-- load rules
require 'rules'

-- load signals
require 'signals'
