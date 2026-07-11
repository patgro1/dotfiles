-------------------------------------------------
-- Power profile widget for Awesome Window Manager
-- Shows the current power-profiles-daemon profile,
-- left click toggles: balanced <-> performance
-------------------------------------------------

local awful = require("awful")
local wibox = require("wibox")
local watch = require("awful.widget.watch")

local GET_CMD = "powerprofilesctl get"
local SET_CMD = "powerprofilesctl set "

local profiles = { "balanced", "performance" }

local function worker(user_args)
    local args = user_args or {}
    local font = args.font
    local label = args.label or " Cpu Mode: "
    local gray = args.gray or "#94928F"
    local timeout = args.timeout or 5

    local powerprofile_widget = wibox.widget.textbox()
    powerprofile_widget.font = font

    local update_widget = function(widget, stdout)
        local profile = stdout:gsub("%s+$", "")
        widget:set_markup(
            '<span font="' .. font .. '"><span foreground="' .. gray .. '">' .. label .. '</span>' ..
            profile .. ' </span>'
        )
    end

    watch(GET_CMD, timeout, update_widget, powerprofile_widget)

    powerprofile_widget:connect_signal("button::press", function(_, _, _, button)
        if button ~= 1 then return end
        awful.spawn.easy_async(GET_CMD, function(stdout)
            local current = stdout:gsub("%s+$", "")
            local idx = 1
            for i, p in ipairs(profiles) do
                if p == current then idx = i end
            end
            local next_profile = profiles[(idx % #profiles) + 1]
            awful.spawn.easy_async(SET_CMD .. next_profile, function()
                update_widget(powerprofile_widget, next_profile)
            end)
        end)
    end)

    local tooltip = awful.tooltip {
        mode = "outside",
        preferred_positions = { "bottom" },
        text = "click to toggle balanced/performance",
    }
    tooltip:add_to_object(powerprofile_widget)

    return powerprofile_widget
end

return setmetatable({}, {
    __call = function(_, ...)
        return worker(...)
    end
})
