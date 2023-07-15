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
            stateVersion = "23.05";
            genericConfiguration = { username, homeDirectory, system }:
                home-manager.lib.homeManagerConfiguration {
                    pkgs = nixpkgs.legacyPackages.${system};
                    extraSpecialArgs = {
                        inherit vim-plug zsh-syntax-highlighting system;
                    };
                    modules = [
                        ./home.nix
                        {
                            home = {
                                inherit homeDirectory username stateVersion;
                            };

                            programs.home-manager.enable = true;
                        }
                        (if nixpkgs.lib.hasInfix "linux" system
                            then { targets.genericLinux.enable = true; }
                            else {})
                    ];
                };
            genericFedoraConfiguration = genericConfiguration rec {
                username = "tdemin";
                homeDirectory = "/home/${username}";
                system = "x86_64-linux";
            };
            genericMacConfiguration = genericConfiguration rec {
                username = "tdemin";
                homeDirectory = "/Users/${username}";
                system = "aarch64-darwin";
            };
        in {
            "tdemin@haseul" = genericFedoraConfiguration;
            "tdemin@yeojin" = genericFedoraConfiguration;
            "tdemin@Hyejoo" = genericMacConfiguration;
            # append new computer configurations here
        };
    };
}
