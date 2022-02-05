# Nix Home Manager configuration

A quick way to bootstrap various development software on a local Linux machine.

## Installing

Install Nix:

```
% curl -L https://nixos.org/nix/install | sh -
```

Clone this repository to `~/.config/nixpkgs`:

```
% git clone https://github.com/tdemin/hm.git ~/.config/nixpkgs
```

Build and activate the first `home-manager` generation (remember to add the necessary `user@machine` pair into `flake.nix` if needed):

```
% cd ~/.config/nixpkgs
% nix build --extra-experimental-features 'nix-command flakes' .#homeConfigurations."${USER}@${HOSTNAME}".activationPackage
% ./result/activate
```
