#!/usr/bin/env bash

safe_source () {
    [[ -f "$1" ]] && source "$1"
}

die () {
    echo "$*" && exit 1
}

IMAGEPATH="/tmp"
IMAGENAME="screen_$(date +%Y-%m-%d_%H:%M:%S).png"

# should declare two variables:
# IMAGEPATH="full path to a directory"
# IMAGENAME="format string ending with an extension"
safe_source "${HOME}/.screenshotrc"

[[ -z "$IMAGEPATH" ]] && die "IMAGEPATH not set, exiting"
[[ -z "$IMAGENAME" ]] && die "IMAGENAME not set, exiting"
FILENAME="$IMAGEPATH/$IMAGENAME"

[[ -z $1 ]] && MAIM_OPTS=""
while [ ! -z $1 ]; do
    case "$1" in
        "--copy")
            CLIPBOARD=true
            ;;
        "--window")
            MAIM_OPTS="-i $(xdotool getactivewindow)"
            ;;
        "--region")
            MAIM_OPTS="-s"
            ;;
        "--file")
            [[ -z "$2" ]] && die "no filename set"
            FILENAME="$2"
            shift 2
            continue
    esac
    shift 1
done

/usr/bin/env maim $MAIM_OPTS "$FILENAME" || die "maim failed to save image"

[[ -z "$FILENAME" ]] && die "no filename set, something's gone wrong"
[[ ! -f "$FILENAME" ]] && die "file doesn't exist, something's gone wrong"

[[ ! -z $CLIPBOARD ]] && xclip -selection clipboard -t image/png < $FILENAME

exit 0
