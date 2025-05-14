#!/usr/bin/env bash
THIS_SCRIPT=$(readlink -f "$0")
CONFIG_DIR=$(dirname $(dirname $THIS_SCRIPT))/config
FONT_LOCAL_DIR=$CONFIG_DIR/fonts
FONT_INSTALL_DIR=/home/$USER/.local/share/fonts

mkdir -p $FONT_INSTALL_DIR

find $FONT_LOCAL_DIR -name '*.ttf' -exec cp {} $FONT_INSTALL_DIR \;
fc-cache -f -v
