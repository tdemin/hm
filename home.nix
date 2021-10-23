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
    android-tools
    ansible
    ansible-lint
    age
    amfora
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
    jq
    jupyter
    gomplate
    maim
    minisign
    mksh
    mpris-scrobbler
    neovim
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
