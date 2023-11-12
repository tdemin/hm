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
        corefonts = pkgs.callPackage ./packages/corefonts {};
    };
    isMacOS = if pkgs.lib.hasInfix "darwin" system then true else false;
    linuxSpecificPackages = pkgs: with pkgs; [
        maim
        minikube
        rkdeveloptool
        zathura
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
        gh
        go
        golangci-lint
        gomplate
        goreleaser
        go-task
        graphviz
        hledger
        hugo
        ipcalc
        jq
        ledger
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
        sshpass
        starship
        texlive.combined.scheme-full
        tmux
        vim
        yarn
        yt-dlp
        zsh
    ] ++ [
        # fonts
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
    ] ++ [
        # custom packages
        overrides.akm
        overrides.corefonts
    ] ++ (if isMacOS then [] else linuxSpecificPackages);
    home.extraOutputsToInstall = [ "doc" ];

    fonts.fontconfig.enable = true;

    home.file.".local/share/nvim/site/autoload/plug.vim".source =
        "${vim-plug}/plug.vim";
    home.file.".local/share/zsh/zsh-syntax-highlighting".source =
        "${zsh-syntax-highlighting}";
}
