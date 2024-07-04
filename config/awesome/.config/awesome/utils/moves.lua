local gears = require("gears")
local awful = require("awful")

local naughty = require("naughty")

local logging = require("utils.logging")


local _M = {}



_M.move_left_right = function(client, direction)
    local direction = direction or "left"

    if client == nil then
        return
    end
    local tag = awful.screen.focused().selected_tag
    local clients = tag:clients()
    -- Check if client have any lefty neighbour and swap if it does
    local swap = false
    for _, _client in pairs(clients) do
        if _client ~= client then
            if (direction == "left" and _client.x < client.x) then
                swap = true
                break
            elseif (direction == "right" and _client.x > client.x) then
                swap = true
                break
            end
        end
    end
    if swap then
        awful.client.swap.bydirection(direction, client)
        return
    end

    -- If we could not swap, check if there is a screen in the direction we want to move
    -- local screen_in_dir = awful.screen.focused().get_next_in_direction(direction)
    local screen_in_dir = awful.screen.focused():get_next_in_direction(direction)
    if screen_in_dir then
        client:move_to_screen(screen_in_dir.index)
    end

end

return _M
