{
    pkgs,
    system,

    vim-plug,
    zsh-syntax-highlighting,
    ...
}:

let
    overrides = {
        akm = pkgs.callPackage ./packages/akm {};
        rescrobbled = pkgs.callPackage ./packages/rescrobbled {};
    };
    isMacOS = if pkgs.lib.hasInfix "darwin" system then true else false;
    linuxSpecificPackages = pkgs: with pkgs; [
        maim
        minikube
        rkdeveloptool
        zathura
    ] ++ [
        # fonts
        corefonts
        dejavu_fonts
        liberation_ttf
        mplus-outline-fonts.osdnRelease
        (nerdfonts.override { fonts = [
            "DejaVuSansMono"
            "DroidSansMono"
            "FiraCode"
            "RobotoMono"
            "UbuntuMono"
        ]; })
        noto-fonts
        noto-fonts-cjk
        noto-fonts-extra
        noto-fonts-emoji
        open-sans
        roboto
        roboto-mono
        source-sans-pro
        ubuntu_font_family
    ];
in rec {
    manual.html.enable = true;
    manual.manpages.enable = true;

    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem
        (pkgs.lib.getName pkg) [
            "corefonts"
        ];
    home.packages = with pkgs; [
        # tools
        age
        amfora
        ansible
        ansible-lint
        aria2
        asdf-vm
        bat
        chezmoi
        direnv
        fd
        fzf
        hugo
        gh
        go
        golangci-lint
        goreleaser
        go-task
        graphviz
        jq
        gomplate
        minisign
        neovim
        patchelf
        restic
        ripgrep
        rustup
        scc
        shellcheck
        shfmt
        socat
        sops
        starship
        texlive.combined.scheme-full
        tmux
        vim
        yarn
        yt-dlp
        zsh
    ] ++ [
        overrides.akm
    ] ++ (if isMacOS then [] else linuxSpecificPackages);
    home.extraOutputsToInstall = [ "doc" ];

    fonts.fontconfig.enable = true;

    systemd.user.services = {};

    home.file.".local/share/nvim/site/autoload/plug.vim".source =
        "${vim-plug}/plug.vim";
    home.file.".local/share/zsh/zsh-syntax-highlighting".source =
        "${zsh-syntax-highlighting}";
}
