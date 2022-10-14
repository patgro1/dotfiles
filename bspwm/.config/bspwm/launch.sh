#!/bin/bash
# Kill all process that needs to be killed and restart then
#

function run() {
    pgrep $1 >> /dev/null || $1 &
}

if type mons; then
    if [ $(xrandr -q | grep " connected" | wc -l) == 2 ]; then
        mons -e right --primary DP-3-1
    fi
fi


run sxhkd
killall picom
picom -b
run dunst
run nm-applet
run blueman-applet
run flameshot

pgrep spotify >> /dev/null || flatpak run com.spotify.Client&

if type mons; then
    pgrep mons >> /dev/null || mons -ax $XDG_CONFIG_HOME/bspwm/dock.sh
fi
