{
    pkgs,
    nixGL,

    vim-plug,
    zsh-syntax-highlighting,
    ...
}:

let
    wrapGL = binaryName: path:
        pkgs.writeShellScriptBin "${binaryName}" ''
            ${nixGL.nixGLIntel}/bin/nixGLIntel ${path} "$@"
        '';
    overrides = {
        akm = pkgs.callPackage ./packages/akm {};
        rescrobbled = pkgs.callPackage ./packages/rescrobbled {};
    };
in rec {
    manual.html.enable = true;
    manual.manpages.enable = true;

    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem
        (pkgs.lib.getName pkg) [
            "corefonts"
        ];
    home.packages = with pkgs; [
        # tools
        act
        age
        overrides.akm
        amfora
        android-tools
        ansible
        ansible-lint
        argo
        argocd
        aria2
        asdf-vm
        bat
        buildah
        chezmoi
        direnv
        docker-compose
        fd
        ffmpeg
        fzf
        hugo
        gh
        go
        golangci-lint
        goreleaser
        go-task
        graphviz
        istioctl
        jq
        jupyter
        gomplate
        k3s
        kompose
        maim
        minikube
        minisign
        mksh
        mpris-scrobbler
        neovim
        patchelf
        restic
        ripgrep
        rkdeveloptool
        rustup
        scc
        shellcheck
        shfmt
        skopeo
        socat
        starship
        texlive.combined.scheme-full
        tmux
        vagrant
        vim
        xclip
        xdotool
        yarn
        youtube-dl
        yt-dlp
        zathura
        zsh
    ] ++ [
        # fonts
        corefonts
        dejavu_fonts
        liberation_ttf
        mplus-outline-fonts.osdnRelease
        nerdfonts
        noto-fonts
        noto-fonts-cjk
        noto-fonts-extra
        noto-fonts-emoji
        open-sans
        roboto
        roboto-mono
        source-sans-pro
        ubuntu_font_family
    ] ++ (builtins.attrValues
        (builtins.mapAttrs (package: version: pkgs."${package}".overrideAttrs (_: rec {
            inherit version;
        })) {
            # TODO: this is useless for actually fixing dependencies
            "kubectl" = "1.23.5";
            "kubernetes-helm" = "3.8.1";
        }
    ));
    home.extraOutputsToInstall = [ "doc" ];

    fonts.fontconfig.enable = true;

    systemd.user.services = {};

    home.file.".local/share/nvim/site/autoload/plug.vim".source =
        "${vim-plug}/plug.vim";
    home.file.".local/share/zsh/zsh-syntax-highlighting".source =
        "${zsh-syntax-highlighting}";
}
