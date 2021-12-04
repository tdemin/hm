# home-manager https://github.com/nix-community/home-manager/archive/master.tar.gz
# nixgl https://github.com/guibou/nixGL/archive/main.tar.gz
# nixpkgs https://nixos.org/channels/nixpkgs-unstable
{
  config,
  pkgs,
  ...
}:

let
  os = import ./os.nix;
  wrapGL = (import ./nixGL.nix { pkgs = pkgs; }).wrapGL;
  overrides = {
    rescrobbled = pkgs.callPackage ./packages/rescrobbled {};
  };
in rec {
  programs.home-manager.enable = true;
  home.username = "tdemin";
  home.homeDirectory = "/home/tdemin";
  home.stateVersion = "21.05";
  manual.html.enable = true;
  manual.manpages.enable = true;

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "corefonts"
  ];
  home.packages = with pkgs; [
    # tools
    act
    age
    amfora
    android-tools
    ansible
    ansible-lint
    argo
    argocd
    aria2
    asdf-vm
    bat
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
    kubectl
    kubernetes-helm
    maim
    minikube
    minisign
    mksh
    mpris-scrobbler
    neovim
    restic
    ripgrep
    rkdeveloptool
    rustup
    scc
    shadowsocks-rust
    shellcheck
    socat
    starship
    texlive.combined.scheme-full
    tmux
    tor
    torsocks
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
    mplus-outline-fonts
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
  ];
  home.extraOutputsToInstall = [ "doc" ];

  fonts.fontconfig.enable = true;

  systemd.user.services = {
    shadowsocks-rust = {
      Unit = {
        Description = "Lightweight SOCKS5 proxy";
      };
      Service = {
        ExecStart = "${pkgs.shadowsocks-rust}/bin/sslocal --config ${home.homeDirectory}/.config/shadowsocks-rust/config.json";
      };
      Install = {
        WantedBy = ["default.target"];
      };
    };
    tor = {
      Unit = {
        Description = "The Onion Router";
        Documentation = "man:tor";
      };
      Service = {
        ExecStart = "${pkgs.tor}/bin/tor";
      };
      Install = {
        WantedBy = ["default.target"];
      };
    };
  };

  home.file.".local/share/nvim/site/autoload/plug.vim".source =
    "${builtins.fetchurl
      "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"}";
}
