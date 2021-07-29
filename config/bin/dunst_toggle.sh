#!/usr/bin/env bash

source "$(dirname $(realpath $0))/common.sh"

notify="notify-send -u low dunst"

case `dunstctl is-paused` in
    true)
        rm ${DUNST_STATUS_FILE} 2>/dev/null
        dunstctl set-paused false
        $notify "Notifications are enabled"
        ;;
    false)
        $notify "Notifications are paused"
        (sleep 3 && dunstctl close && touch ${DUNST_STATUS_FILE} && dunstctl set-paused true) &
        ;;
esac
