nix_install_url="https://nixos.org/nix/install"

nix_config_file=${XDG_CONFIG_HOME:-$HOME/.config}/nix/nix.conf
nix_tmpdir=${XDG_CACHE_HOME:-$HOME/.cache}/nix-build

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
