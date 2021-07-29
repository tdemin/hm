#!/usr/bin/env bash

session=`tmux list-sessions -F '#{session_name}' | rofi -dmenu`
[[ $? == 0 ]] && exec alacritty -e tmux attach-session -t "$session"
