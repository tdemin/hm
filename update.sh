#!/usr/bin/env bash

set -euo pipefail

hm_path=$(dirname "$(realpath -s $0)")
source "$hm_path/common.sh"

usage () {
    die "Usage: $0 [-u]"
}

update_flake () {
    echo "Updating flake..."
    cmd nix flake update "$hm_path"
}

update_home-manager () {
    echo "Rebuilding the profile with the new revision..."
    cmd TMPDIR="$nix_tmpdir" home-manager switch --flake "$hm_path#${USER}@${HOSTNAME}"
}

main () {
    while getopts ":u" o; do
        case "${o}" in
            u)
                will_update_flake=1
                ;;
            *)
                usage
                ;;
        esac
    done
    shift $((OPTIND-1))

    create_nix_tmpdir
    if [ ! -z "${will_update_flake:-}" ]; then
        update_flake
    fi
    update_home-manager
}

main $@
