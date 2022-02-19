# Nix Home Manager configuration

A quick way to bootstrap various development software on a local Linux machine.

## Installing

Clone this repository to `~/.config/nixpkgs`:

```
% git clone https://github.com/tdemin/hm.git ~/.config/nixpkgs
```

Build and activate the first `home-manager` generation (remember to add the necessary `user@machine` pair into `flake.nix` if needed):

```
% $EDITOR ~/.config/nixpkgs/flake.nix
% ~/.config/nixpkgs/install.sh -i
```

## Updating

Run the updater script:

```
% ~/.config/nixpkgs/update.sh -u
```
