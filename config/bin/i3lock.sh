#!/usr/bin/env bash

source "$(dirname $(realpath $0))/common.sh"

# pause dunst notifications on SIGUSR1, lock, unpause on unlock

[[ ! -z $(pgrep i3lock) ]] && exit
(
    dunstctl set-paused true ;
    i3lock -c 000000 -f --nofork --clock --indicator --timecolor f0f0f0ff ;
    [[ ! -f ${DUNST_STATUS_FILE} ]] && dunstctl set-paused false
) &
