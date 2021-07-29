{
  config,
  pkgs,
  ...
}:

let
  nixGL = (pkgs.callPackage "${builtins.fetchTarball {
    url = https://github.com/guibou/nixGL/archive/master.tar.gz;
  }}/nixGL.nix" {}).nixGLIntel;
  wrapGL = binaryName: path: pkgs.writeShellScriptBin "${binaryName}" ''
    ${nixGL}/bin/nixGLIntel ${path} "$@"
  '';
  overrides = {
    mpv = wrapGL "mpv" "${pkgs.mpv}/bin/mpv";
    alacritty = wrapGL "alacritty" "${pkgs.alacritty}/bin/alacritty";
    copyq = pkgs.libsForQt5.callPackage ./packages/copyq {};
    rescrobbled = pkgs.callPackage ./packages/rescrobbled {};
  };
in rec {
  programs.home-manager.enable = true;

  home.username = "tdemin";
  home.homeDirectory = "/home/tdemin";

  home.stateVersion = "21.05";

  home.packages = with pkgs; [
    overrides.alacritty
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
    overrides.mpv
    neovim
    neovim-qt
    nodejs
    python3
    python
    libsForQt5.qtstyleplugins
    overrides.rescrobbled
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
  ];

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
    } // import ./os.nix;
    pkgs = pkgs;
    config = config;
  };
}
