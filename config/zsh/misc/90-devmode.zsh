DEVMODE_ROOT="${HOME}/Desktop"

tempdir () {
    dev_prevdir="$(pwd)"
    dev_date="$(date +%Y-%m-%d-%H-%M)"
    local dev_files="$1"
    mkdir -p "${DEVMODE_ROOT}/${dev_date}"
    [[ ! -z "${dev_files}" ]] && cp -r "${dev_files}" "${DEVMODE_ROOT}/${dev_date}"
    [[ ! -z "${dev_files}" ]] && rm -ri "${dev_files}"
    cd "${DEVMODE_ROOT}/${dev_date}"
    alias exit="tempdir_exit"
}

tempdir_exit () {
    cd "${dev_prevdir}"
    rm -rf "${DEVMODE_ROOT}/${dev_date}"
    unalias exit
    unset dev_date
    unset dev_prevdir
}
