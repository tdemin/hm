nix_install_url="https://nixos.org/nix/install"

nix_config_file=${XDG_CONFIG_HOME:-$HOME/.config}/nix/nix.conf
nix_tmpdir=${XDG_CACHE_HOME:-$HOME/.cache}/nix-build

host=$(tr '[:upper:]' '[:lower:]' <<< $HOSTNAME)

die () {
    echo "$@" 1>&2
    exit 1
}

cmd () {
    echo "/usr/bin/env $@"
    /usr/bin/env $@
}

create_nix_tmpdir () {
    echo "Creating Nix temporary dir..."
    cmd mkdir -p "$nix_tmpdir"
}

source_nix_profile () {
    # TODO: find out if .nix-profile can be located elsewhere
    local nix_profile_location="${HOME}/.nix-profile/etc/profile.d/nix.sh"
    if [ -f $nix_profile_location ]; then
        source $nix_profile_location
    else
	echo "$nix_profile_location doesn't exist, likely not on Linux"
    fi
}

os_type=""

detect_os_type () {
    if [ -z "$os_type" ]; then
        os_type=$(uname -s)
    fi
}

realpath () {
    detect_os_type
    if [ $os_type -eq Darwin ]; then
        command realpath $@
    else
        command realpath -q $@
    fi
}
