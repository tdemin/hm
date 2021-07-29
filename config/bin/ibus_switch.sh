#!/usr/bin/env bash

# utilities for switching language with both XKB and I-Bus as those might
# be out of sync in lots of scenarios

set_layout () {
    setxkbmap -model $1 -layout $2
    ibus engine $3
}

switch_japanese () {
    set_layout pc105 jp mozc-jp
}

do_regular_switch () {
    case `ibus engine` in
        "xkb:us::eng")
            set_layout pc104 ru xkb:ru::rus
            ;;
        "xkb:ru::rus")
            set_layout pc104 us xkb:us::eng
            ;;
        *)
            set_layout pc104 us xkb:us::eng
            ;;
    esac
}

do_japanese_switch () {
    case `ibus engine` in
        "mozc-jp")
            set_layout pc104 us xkb:us::eng
            ;;
        *)
            switch_japanese
            ;;
    esac
}

case $1 in
    "regular") do_regular_switch ;;
    "japanese") do_japanese_switch ;;
    "targeted") set_layout $2 $3 $4 ;;
    *) do_regular_switch ;;
esac
