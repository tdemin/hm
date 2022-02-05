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
    };
    outputs = inputs@{ self, nixpkgs, home-manager, nixGL,
        vim-plug, zsh-syntax-highlighting, ... }: {
        homeConfigurations = let
            stateVersion = "21.11";
            genericConfiguration = { username, homeDirectory, system }:
                home-manager.lib.homeManagerConfiguration {
                    system = system;
                    homeDirectory = homeDirectory;
                    username = username;
                    stateVersion = stateVersion;
                    extraSpecialArgs = {
                        nixGL = nixGL;
                        vim-plug = vim-plug;
                        zsh-syntax-highlighting = zsh-syntax-highlighting;
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
        };
    };
}
