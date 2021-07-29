up0x0 () {
    [[ -z "$1" ]] && return 1
    curl -F "file=@$1" https://0x0.st || return 1
}

cheat () {
    curl cheat.sh/$1
}

wttr () {
    curl wttr.in/$1
}

go-install () {
    if [[ "$1" == "-m" ]]; then
        shift 1
        GO111MODULE=on go get -v $@
    else
        go get -u -v $@
    fi
} 
