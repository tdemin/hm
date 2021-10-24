{ pkgs, ... }: rec {
  nixGL = (import <nixgl>).nixGLIntel;
  wrapGL = binaryName: path:
    pkgs.writeShellScriptBin "${binaryName}" ''
      ${nixGL}/bin/nixGLIntel ${path} "$@"
    '';
}
