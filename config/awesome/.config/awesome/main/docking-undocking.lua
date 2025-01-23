local awful = require("awful")
local naughty = require("naughty")

local tag_store = {}

tag.connect_signal("request:screen", function(t)
    local fallback_tag = nil

    -- Find a tag with the same name on any other screen
    for other_screen in screen do
        if other_screen ~= t.screen then
            fallback_tag = awful.tag.find_by_name(other_screen, t.name)
            if fallback_tag ~= nil then
                break
            end
        end
    end

    -- No tag with the same name was found, pick one randomly
    if fallback_tag == nil then
        fallback_tag = awful.tag.find_fallback()
    end

    if not (fallback_tag == nil) then
        local output = next(t.screen.outputs)
        if tag_store[output] == nil then
            tag_store[output] = {}
        end

        clients = t:clients()
        tag_store[output][t.name] = clients

        for _, c in ipairs(clients) do
            c:move_to_tag(fallback_tag)
        end
    end
end)


screen.connect_signal("added", function(new_screen)
    local output = next(new_screen.outputs)
    naughty.notify({ text = output .. " Connected" })
    local screen_tags = tag_store[output]
    if not (screen_tags == nil) then
        naughty.notify({ text = "Restoring tags" })
        for _, tag in ipairs(new_screen.tags) do
            local clients = screen_tags[tag.name]
            if not (clients == nil) then
                for _, client in ipairs(clients) do
                    if not (client == nil) then
                        client:move_to_tag(tag)
                    end
                end
            end
        end
    end
end)


-- This function fixes an issue where clients are removed and then
-- the docks state changes and we erroneously attemp to restore the dead client
client.connect_signal(
    "unmanage",
    function(c)
        for _, tag_list in pairs(tag_store) do
            for _, tag in pairs(tag_list) do
                for i, client in ipairs(tag) do
                    if c == client then
                        -- Remove the client from any saved tag
                        table.remove(tag, i)
                        break
                    end
                end
            end
        end
    end
)
