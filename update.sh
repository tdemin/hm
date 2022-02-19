#!/usr/bin/env bash

set -euo pipefail

nix_tmpdir=${XDG_CACHE_HOME:-$HOME/.cache}/nix-build

hm_path=$(dirname "$(realpath -s $0)")

die () {
    echo "$@" 1>&2
    exit 1
}

usage () {
    die "Usage: $0 [-u]"
}

cmd () {
    echo "/usr/bin/env $@"
    /usr/bin/env $@
}

update_flake () {
    echo "Updating flake..."
    cmd nix flake update "$hm_path"
}

update_home-manager () {
    echo "Rebuilding the profile with the new revision..."
    cmd TMPDIR="$nix_tmpdir" home-manager switch --flake "$hm_path"
}

create_nix_tmpdir () {
    echo "Creating Nix temporary dir..."
    cmd mkdir -p "$nix_tmpdir"
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
