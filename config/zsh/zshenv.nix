params: let
    optional = params.lib.optional;
    notNixOS = params.data.os != "NixOS";
in
''
export EDITOR="nvim"
export VISUAL="nvim"
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin:$HOME/.local/bin"

${optional (notNixOS) "export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive"}

if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
    source "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

export XDG_DATA_DIRS="$HOME/.nix-profile/share:$XDG_DATA_DIRS"
''
