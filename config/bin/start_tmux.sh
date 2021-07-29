#!/usr/bin/env bash

# starts new session of tmux or tries to create/open a floating session
# if passed with -f

[[ "$1" == "-f" ]] && exec tmux new-session -A -s float
exec tmux new-session
