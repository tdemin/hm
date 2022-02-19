#!/usr/bin/env bash

set -euo pipefail

hm_path=$(dirname "$(realpath -s $0)")
source "$hm_path/common.sh"

install_nix () {
    echo "Installing Nix package manager..."
    tmpfile=$(mktemp)
    cmd curl -L -o "$tmpfile" "$nix_install_url"
    cmd sh "$tmpfile"
}

write_nix_config_file () {
    if [ -f "$nix_config_file" ]; then
        return
    fi
    echo "Writing Nix config file at $nix_config_file..."
    cmd mkdir -p "$(dirname $nix_config_file)"
    cat > "$nix_config_file" <<EOF
extra-experimental-features = nix-command flakes
EOF
}

source_nix_profile () {
    # TODO: find out if .nix-profile can be located elsewhere
    source "${HOME}/.nix-profile/etc/profile.d/nix.sh"
}

build_activate_generation () {
    result_path="$hm_path/result"
    echo "Building the profile..."
    cmd TMPDIR="$nix_tmpdir" nix build \
        -o "$result_path" \
        "$hm_path#homeConfigurations.\"$USER@$HOSTNAME\".activationPackage"
    echo "Activating the initial home-manager generation..."
    cmd sh "$result_path/activate"
}

usage () {
    die "Usage: $0 [-i]"
}

main () {
    while getopts ":i" o; do
        case "${o}" in
            i)
                will_install_nix=1
                ;;
            *)
                usage
                ;;
        esac
    done
    shift $((OPTIND-1))

    if [ -z "$(which nix)" ]; then
        if [ ! -z "${will_install_nix:-}" ]; then
            install_nix
        else
            die "Nix appears not to be installed. Use -i to force Nix installation."
        fi
    fi

    create_nix_tmpdir
    write_nix_config_file
    source_nix_profile
    build_activate_generation
}

main $@