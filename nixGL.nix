{ pkgs, ... }: rec {
  package = builtins.fetchTarball {
    url = https://github.com/guibou/nixGL/archive/master.tar.gz;
  };
  nixGL = (pkgs.callPackage "${package}/nixGL.nix" {}).nixGLIntel;
  wrapGL = binaryName: path:
    pkgs.writeShellScriptBin "${binaryName}" ''
      ${nixGL}/bin/nixGLIntel ${path} "$@"
    '';
}
