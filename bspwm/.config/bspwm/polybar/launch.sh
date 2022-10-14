#!/bin/bash
# Start polybar on all monitors
killall polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
 
for m in $(polybar -m | cut -d":" -f1); do
    MONITOR=$m polybar -c $XDG_CONFIG_HOME/bspwm/polybar/config.ini --reload workspaces&
done
polybar -c $XDG_CONFIG_HOME/bspwm/polybar/config.ini --reload media&
polybar -c $XDG_CONFIG_HOME/bspwm/polybar/config.ini --reload system_status&
sleep 1
xdo raise -N Polybar
polybar-msg cmd hide



