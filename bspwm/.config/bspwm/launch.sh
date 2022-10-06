#!/bin/bash
# Kill all process that needs to be killed and restart then
#

function run() {
    pgrep $1 >> /dev/null || $1 &
}

run sxhkd
killall picom
picom -b
run dunst
run nm-applet
run blueman-applet

pgrep mons >> /dev/null || mons -ax $XDG_CONFIG_HOME/bspwm/dock.sh
