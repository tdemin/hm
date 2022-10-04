{
    description = "Home Manager configuration for Timur Demin";
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        nixGL.url = "github:guibou/nixGL/main";
        nixGL.inputs.nixpkgs.follows = "nixpkgs";

        vim-plug.url = "github:junegunn/vim-plug/master";
        vim-plug.flake = false;
        zsh-syntax-highlighting.url = "github:zsh-users/zsh-syntax-highlighting/master";
        zsh-syntax-highlighting.flake = false;

        nixpkgsK8s.url = "github:NixOS/nixpkgs/bf972dc380f36a3bf83db052380e55f0eaa7dcb6";
    };
    outputs = inputs@{ self, nixpkgs, home-manager, nixGL,
        vim-plug, zsh-syntax-highlighting, nixpkgsK8s, ... }: {
        homeConfigurations = let
            stateVersion = "21.11";
            genericConfiguration = { username, homeDirectory, system }:
                let k8s = import nixpkgsK8s {
                    inherit system;
                }; in
                home-manager.lib.homeManagerConfiguration {
                    inherit system homeDirectory username stateVersion;
                    extraSpecialArgs = {
                        inherit nixGL vim-plug zsh-syntax-highlighting k8s;
                    };
                    configuration = { config, pkgs, ... }: {
                        programs.home-manager.enable = true;
                        targets.genericLinux.enable = true;
                        imports = [
                            ./home.nix
                        ];
                    };
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
