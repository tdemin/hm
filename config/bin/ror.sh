#!/usr/bin/env bash

# algorithm:
# :check: 1. window open and is focused? move it to scratchpad
# :check: 2. window open and is not focused? move to current, raise it
# :check: 3. window not open? run the program

case "$1" in
    "class" )
        window=`xdotool search --limit 1 --class "$2"`
        crit="class";;
    "instance" )
        window=`xdotool search --limit 1 --classname "$2"`
        crit="instance";;
    "name" )
        window=`xdotool search --limit 1 --name "$2"`
        crit="title";;
esac
if [ -z "$window" ]; then
    $3 # 3
else
    window_pid=`xdotool getwindowpid $window`
    active_window_pid=`xdotool getwindowpid $(xdotool getwindowfocus)`
    if [ "$window_pid" -eq "$active_window_pid" ]; then
        # 1
        i3-msg "[$crit=(?i)$2] move container to workspace $4"
    else
        # 2
        i3-msg "[$crit=(?i)$2] move container to workspace current"
        i3-msg "[$crit=(?i)$2] focus"
    fi
fi
