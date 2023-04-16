{
    description = "Home Manager configuration for Timur Demin";
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        vim-plug.url = "github:junegunn/vim-plug/master";
        vim-plug.flake = false;
        zsh-syntax-highlighting.url = "github:zsh-users/zsh-syntax-highlighting/master";
        zsh-syntax-highlighting.flake = false;
    };
    outputs = inputs@{ self, nixpkgs, home-manager,
        vim-plug, zsh-syntax-highlighting, ... }: {
        homeConfigurations = let
            stateVersion = "22.11";
            genericConfiguration = { username, homeDirectory, system }:
                home-manager.lib.homeManagerConfiguration {
                    pkgs = nixpkgs.legacyPackages.${system};
                    extraSpecialArgs = {
                        inherit vim-plug zsh-syntax-highlighting;
                    };
                    modules = [
                        ./home.nix
                        {
                            home = {
                                inherit homeDirectory username stateVersion;
                            };

                            programs.home-manager.enable = true;
                            targets.genericLinux.enable = true;
                        }
                    ];
                };
            genericFedoraConfiguration = genericConfiguration {
                username = "tdemin";
                homeDirectory = "/home/tdemin";
                system = "x86_64-linux";
            };
        in {
            "tdemin@haseul" = genericFedoraConfiguration;
            "tdemin@yeojin" = genericFedoraConfiguration;
            # append new computer configurations here
        };
    };
}
