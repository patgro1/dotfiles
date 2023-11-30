#!/bin/bash
# Start polybar on all monitors
killall polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
 
if type "xrandr"; then
    for m in $(polybar -m | cut -d":" -f1); do
        MONITOR=$m polybar -c $XDG_CONFIG_HOME/bspwm/polybar/config.ini --reload top &
    done
else
    polybar --reload top &
fi


