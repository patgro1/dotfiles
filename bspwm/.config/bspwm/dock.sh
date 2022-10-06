#!/bin/bash
case $MONS_NUMBER in
    1)
        echo "Single"
        mons -o
        ;;
    2)
        echo "Dual"
        mons -e left
        ;;
esac
bspc wm -r
