local wezterm = require 'wezterm'
local config = {};

local function is_dir(path_str)
    local entries = wezterm.read_dir(path_str)
    -- If `read_dir` returns a table, it's a directory.
    -- Otherwise, it returned nil because it couldn't be read.
    return type(entries) == 'table'
end

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true
config.max_fps = 120

-- config.color_scheme = "Catppuccin Mocha"
config.color_scheme = "gruvbox_material_dark_medium"
config.color_schemes = {
    ["gruvbox_material_dark_hard"] = {
        foreground = "#D4BE98",
        background = "#1D2021",
        cursor_bg = "#D4BE98",
        cursor_border = "#D4BE98",
        cursor_fg = "#1D2021",
        selection_bg = "#D4BE98",
        selection_fg = "#3C3836",

        ansi = { "#1d2021", "#ea6962", "#a9b665", "#d8a657", "#7daea3", "#d3869b", "#89b482", "#d4be98" },
        brights = { "#eddeb5", "#ea6962", "#a9b665", "#d8a657", "#7daea3", "#d3869b", "#89b482", "#d4be98" },
    },
    ["gruvbox_material_dark_medium"] = {
        foreground = "#D4BE98",
        background = "#282828",
        cursor_bg = "#D4BE98",
        cursor_border = "#D4BE98",
        cursor_fg = "#282828",
        selection_bg = "#D4BE98",
        selection_fg = "#45403d",

        ansi = { "#282828", "#ea6962", "#a9b665", "#d8a657", "#7daea3", "#d3869b", "#89b482", "#d4be98" },
        brights = { "#eddeb5", "#ea6962", "#a9b665", "#d8a657", "#7daea3", "#d3869b", "#89b482", "#d4be98" },
    },
}
wezterm.on('update-right-status', function(window, pane)
    window:set_right_status(window:active_workspace())
end)
-- Tab bar config
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true

config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
config.warn_about_missing_glyphs = false
config.font = wezterm.font_with_fallback({
    { family = 'FiraCode Nerd Font' },
    { family = 'Noto Sans Telugu UI' },
    { family = 'Noto Sans Telugu' }
})
config.font_size = 10
config.window_frame = {
    font = wezterm.font { family = "FiraCode Nerd Font" },
    font_size = 10
}

-- Keymaps
local act = wezterm.action
config.leader = { key = 'a', mods = 'ALT', timeout_milliseconds = 1000 }
config.keys = {
    -- Tab creation and navigation
    {
        key = 'c',
        mods = 'LEADER',
        action = act.SpawnTab 'CurrentPaneDomain'
    },
    {
        key = 'x',
        mods = 'LEADER',
        action = act.CloseCurrentPane { confirm = false }
    },
    {
        key = 'o',
        mods = 'LEADER',
        action = act.ActivateLastTab
    },
    {
        key = 'p',
        mods = 'LEADER',
        action = act.ActivateTabRelative(-1)
    },
    {
        key = 'n',
        mods = 'LEADER',
        action = act.ActivateTabRelative(1)
    },
    -- Pane creation and navigation
    {
        key = '|',
        mods = 'LEADER|SHIFT',
        action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }
    },
    {
        key = '_',
        mods = 'LEADER|SHIFT',
        action = act.SplitVertical { domain = 'CurrentPaneDomain' }
    },
    {
        key = 'h',
        mods = 'LEADER',
        action = act.ActivatePaneDirection 'Left'
    },
    {
        key = 'j',
        mods = 'LEADER',
        action = act.ActivatePaneDirection 'Down'
    },
    {
        key = 'k',
        mods = 'LEADER',
        action = act.ActivatePaneDirection 'Up'
    },
    {
        key = 'l',
        mods = 'LEADER',
        action = act.ActivatePaneDirection 'Right'
    },

    {
        key = '2',
        mods = 'ALT',
        action = wezterm.action.SendKey { key = 'F2' },
    }
}
-- Tab navigation that is indexed based
for i = 0, 9 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = 'LEADER',
        action = wezterm.action.ActivateTab(i)
    })
end
return config
