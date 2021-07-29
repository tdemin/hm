params: with params; let
  mkRWLink = config.lib.file.mkOutOfStoreSymlink;
in {
  ".config/mpv/mpv.conf".source = ./config/mpv.conf;
  ".config/alacritty/alacritty.yml".text = import ./config/alacritty.nix params;
  ".config/go/env".text = import ./config/goenv.nix params;
  # VSCode needs to have its configs writable
  ".config/Code/User/keybindings.json".source = mkRWLink ./config/vscode/keybindings.json;
  ".config/Code/User/settings.json".source = mkRWLink ./config/vscode/settings.json;
  ".config/nvim/coc-settings.json".source = ./config/nvim/coc-settings.json;
  ".config/nvim/ginit.vim".source = ./config/nvim/ginit.vim;
  ".config/nvim/init.vim".source = ./config/nvim/init.vim;
  ".config/qutebrowser/config.py".source = ./config/qutebrowser/config.py;
  ".config/rofi/config.rasi".source = ./config/rofi.conf;
  ".config/starship.toml".source = ./config/starship.toml;
  ".config/yay/config.json".source = ./config/yay.json;
  ".gitconfig".source = ./config/gitconfig;
  ".local/bin/" = {
    source = ./config/bin;
    recursive = true;
  };
  ".local/share/qutebrowser/" = {
    source = ./config/qutebrowser/profile;
    recursive = true;
  };
  ".screenshotrc".source = ./config/screenshotrc;
  ".tmux.conf".source = ./config/tmux.conf;
  ".zshenv".text = import ./config/zsh/zshenv.nix params;
  ".zshrc".source = ./config/zsh/zshrc;
  ".config/zsh/" = {
    source = ./config/zsh/misc;
    recursive = true;
  };
  ".config/zsh/10-dirs.zsh".text = import ./config/zsh/dirs.nix params;
  ".config/zsh/99-plugins.zsh".text = import ./config/zsh/plugins.nix params;
} // lib.optionalAttrs (lib.dictKey data "i3" != null) {
  ".config/i3/config".text = import ./config/i3.nix params;
}
