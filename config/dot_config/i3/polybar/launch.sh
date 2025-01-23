#!/usr/bin/env bash

# polybar-msg cmd quit
pkill polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

echo "---" | tee -a /tmp/polybar_left.log
echo "---" | tee -a /tmp/polybar_center.log
echo "---" | tee -a /tmp/polybar_right.log


if type "xrandr"; then
    for m in $(polybar -m | cut -d":" -f1); do
        echo $m
        MONITOR=$m polybar left -r -c $HOME/.config/i3/polybar/config.ini 2>&1 | tee -a /tmp/polybar_left.log & disown
        MONITOR=$m polybar center -r -c  $HOME/.config/i3/polybar/config.ini 2>&1 | tee -a /tmp/polybar_center.log & disown
        MONITOR=$m polybar right -r -c  $HOME/.config/i3/polybar/config.ini 2>&1 | tee -a /tmp/polybar_right.log & disown
    done
fi;
