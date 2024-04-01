local wezterm = require 'wezterm'
local config = {};

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.color_scheme = "Catppuccin Mocha"
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
config.font = wezterm.font 'FiraCode Nerd Font'
config.font_size = 12
config.window_frame = {
    font = wezterm.font { family = "FiraCode Nerd Font" },
    font_size = 10
}

return config
