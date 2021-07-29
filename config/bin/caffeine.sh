#!/usr/bin/env bash

source "$(dirname $(realpath $0))/common.sh"

status=`xset -q | grep 'DPMS is' | awk '{ print $3 }'`

if [ $status == 'Enabled' ]; then
    xset -dpms && xset s off && notify-send 'Screen suspend is disabled.'
else
    xset +dpms && xset s $DISPLAY_TIMEOUT && notify-send 'Screen suspend is enabled.'
fi
