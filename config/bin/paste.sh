#!/usr/bin/env bash

set -euo pipefail

HASTEBIN_SERVER="https://paste.git.tdem.in"
[[ -f ~/.pasterc ]] && source ~/.pasterc

key=`curl -s -XPOST "$HASTEBIN_SERVER/documents" -d "$(</dev/stdin)" | jq .key | tr -d '"'`

printf "%s/raw/%s\n" $HASTEBIN_SERVER $key
