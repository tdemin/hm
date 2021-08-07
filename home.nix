{
  config,
  pkgs,
  ...
}:

let
  os = import ./os.nix;
  wrapGL = (import ./nixGL.nix { pkgs = pkgs; }).wrapGL;
  overrides = {
    mpv = wrapGL "mpv" "${pkgs.mpv}/bin/mpv";
    alacritty = wrapGL "alacritty" "${pkgs.alacritty}/bin/alacritty";
    copyq = pkgs.callPackage ./packages/copyq {};
    rescrobbled = pkgs.callPackage ./packages/rescrobbled {};
    doublecmd = pkgs.callPackage ./packages/doublecmd {};
  };
in rec {
  programs.home-manager.enable = true;
  home.username = "tdemin";
  home.homeDirectory = "/home/tdemin";
  home.stateVersion = "21.05";
  manual.html.enable = true;
  manual.manpages.enable = true;

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # tools
    ansible
    age
    amfora
    bat
    clang
    direnv
    docker-compose
    fzf
    fd
    hugo
    git
    go
    golangci-lint
    goreleaser
    go-task
    graphviz
    jq
    gomplate
    minisign
    mksh
    mpris-scrobbler
    neovim
    nodejs
    python3
    python
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
    vim
    yarn
    youtube-dl
    zsh
  ] ++ [
    # graphical packages
    overrides.alacritty
    anki
    claws-mail
    copyq
    # overrides.doublecmd
    drawio
    element-desktop
    foliate
    gajim
    hexchat
    keepassxc
    libreoffice-still
    overrides.mpv
    neovim-qt
    nextcloud-client
    nomacs
    pdfsam-basic
    pinta
    qbittorrent
    qt5ct
    remmina
    tdesktop
    wireshark
    vscode-fhs
    zotero
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
  ] ++ [
    # eyecandy
    cinnamon.mint-y-icons
    cinnamon.mint-themes
    ubuntu-themes
  ];
  home.extraOutputsToInstall = [ "doc" ];

  fonts.fontconfig.enable = true;
  gtk = {
    enable = true;
    font = {
      package = pkgs.ubuntu_font_family;
      name = "Ubuntu";
      size = 11;
    };
    iconTheme = {
      package = pkgs.cinnamon.mint-y-icons;
      name = "Mint-Y-Red";
    };
    theme = {
      package = pkgs.cinnamon.mint-themes;
      name = "Mint-Y-Red";
    };
  };
  qt = {
    enable = true;
    platformTheme = "gtk";
    style.name = "gtk2";
  };
  xsession.pointerCursor = {
    package = pkgs.vanilla-dmz; # TODO: DMZ-White
    name = "DMZ-White";
  };
  xresources.extraConfig = ''
    Xft.autohint: 0
    Xft.lcdfilter: lcddefault
    Xft.hintstyle: hintslight
    Xft.hinting: 1
    Xft.antialias: 1
    Xft.rgba: rgb
  '';

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

  xdg.desktopEntries = {
    alacritty = {
      name = "Alacritty";
      genericName = "Terminal emulator";
      exec = "${overrides.alacritty}/bin/alacritty";
      terminal = false;
      categories = ["System" "TerminalEmulator" "Utility"];
      comment = "A GPU-accelerated terminal emulator written in Rust";
      icon = "terminal";
      startupNotify = true;
    };
  };

  home.file = import ./files.nix {
    lib = pkgs.lib // {
      dictKey = dict: key: key . dict or null;
      optional = condition: thenValue: if condition then thenValue else null;
      optionalElse = condition: thenValue: elseValue:
        if condition then thenValue else elseValue;
    };
    data = {
      go.privatePackages = [
        "tdem.in/mk_project"
        "git.tdem.in/tdemin/vkr_awp"
      ];
    } // os;
    pkgs = pkgs;
    config = config;
  };
}
