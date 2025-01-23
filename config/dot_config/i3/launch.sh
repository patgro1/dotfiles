#!/bin/bash
# Kill all process that needs to be killed and restart then
#

function run() {
    pgrep $1 >> /dev/null || $1 &
}

killall picom
picom -b --config $HOME/.config/i3/picom/picom.conf
run dunst
run nm-applet
run blueman-applet
run flameshot

run $HOME/.config/i3/polybar/launch.sh

# pgrep mons >> /dev/null || mons -ax $XDG_CONFIG_HOME/bspwm/dock.sh
