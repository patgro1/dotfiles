#!/usr/bin/env bash
THIS_SCRIPT=$(readlink -f "$0")
CONFIG_DIR=$(dirname $(dirname $THIS_SCRIPT))/config
DOT_CONFIG_DIR=$HOME/.config

# Glob dot files too
shopt -s dotglob
# Remove all links between the .config folder and the dot_config folder
for dir in $CONFIG_DIR/dot_config/*
do
    dir=${dir%*/}
    name=$(basename $dir)
    target="$DOT_CONFIG_DIR/$name"
    if [ -d $target ] || [ -f $target ]; then
        if [ ! -L $target ]; then
            echo "Conflict for $name. A directory already exists in $DOT_CONFIG_DIR"
        else
            rm $target
        fi
    fi
done

for dir in $CONFIG_DIR/home/*
do
    dir=${dir%*/}
    name=$(basename $dir)
    target="$HOME/$name"
    if [ -d $target ] || [ -f $target ]; then
        if [ ! -L $target ]; then
            echo "Conflict for $name. A directory already exists in $HOME"
        else
            rm $target
        fi
    fi
done

for dir in $CONFIG_DIR/dot_local/*
do
    dir=${dir%*/}
    name=$(basename $dir)
    target="$HOME/.local/$name"
    if [ -d $target ] || [ -f $target ]; then
        if [ ! -L $target ]; then
            echo "Conflict for $name. A directory already exists in $HOME/.local"
        else
            rm $target
        fi
    fi
done
# Restore dot files not globbed
shopt -u dotglob
