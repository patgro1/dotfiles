#!/usr/bin/sh

start_if_no_exist () {
    if ! pgrep -x $1 >> /dev/null
    then
        echo "starting $1"
        $1 &
    fi
}

kill_and_start  () {
    pkill $1
    $1

}

kill_and_start kanshi
