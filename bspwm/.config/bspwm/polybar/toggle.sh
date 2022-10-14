#!/bin/bash

# Workspace bar will always be visible if any bar is visible (media might be hidden if no player is running)
is_visible=$(xdotool search --onlyvisible --name polybar-workspace)
to_cmd="hide"

workspace_bars=$(xdotool search --name polybar-workspaces)
workspace_bar_wpid=()
for workspace_bar in $workspace_bars; do
    workspace_bar_wpid+="$(xdotool getwindowpid $workspace_bar) "
done
status_bar=$(xdotool search --name polybar-system_status getwindowpid)
media_bar=$(xdotool search --name polybar-media getwindowpid)


if [ "$is_visible" = "" ]; then
    to_cmd="show"
fi

for workspace_bar in $workspace_bar_wpid; do
    polybar-msg -p $workspace_bar cmd $to_cmd
done
polybar-msg -p $status_bar cmd $to_cmd

player_status="$(playerctl metadata 2>&1)"
if [[ "$player_status" != "No players"* ]]; then
    polybar-msg -p $media_bar cmd $to_cmd
else
    polybar-msg -p $media_bar cmd hide
fi

xdo raise -N Polybar

