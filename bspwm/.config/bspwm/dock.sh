#!/bin/bash
EXT_MONITOR=DP-3-1
INT_MONITOR=eDP-1
DESKTOP_ORDER="1 2 3 4 5 6 7 8 9 0"
EXT_DESKTOP="1 2 3 4 5 6 7"

add_monitor () {
    for desktop in $EXT_DESKTOP; do
        bspc desktop $desktop --to-monitor $EXT_MONITOR
    done
    # BSPWM will create a desktop called desktop on creation
    bspc desktop Desktop --remove
}

remove_monitor() {
    ext_desktops=$(bspc query -D -m $EXT_MONITOR)
    # Add a temporary desktop to the old monitor
    bspc monitor $EXT_MONITOR -a temp
    for desktop in $ext_desktops; do 
        bspc desktop $desktop --to-monitor $INT_MONITOR
    done
    bspc monitor $INT_MONITOR --reorder-desktops $DESKTOP_ORDER
    bspc monitor $EXT_MONITOR --remove
    bspc desktop temp --remove
}

case $MONS_NUMBER in
    1)
        echo "Single"
        remove_monitor
        mons -o
        ;;
    2)
        echo "Dual"
        mons -e right
        add_monitor
        ;;
esac
$XDG_CONFIG_HOME/bspwm/polybar/launch.sh
feh --bg-scale ~/.config/images/wallpaper.png
