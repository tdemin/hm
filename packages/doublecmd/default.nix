{ lib, stdenv,
  lazarus, fpc, gtk2, gtk2-x11, dbus, which }:

stdenv.mkDerivation rec {
  pname = "doublecmd-gtk2";
  version = "0.9.10";

  src = builtins.fetchTarball {
    url = "http://sourceforge.net/projects/doublecmd/files/Double%20Commander%20Source/doublecmd-${version}-src.tar.gz/download";
    sha256 = "0m4v1d1fdsh74jbqylapwrhj802sg67h9blbl37jbcb8s37pnx30";
  };

  nativeBuildInputs = [ lazarus fpc which ];
  buildInputs = [ gtk2 gtk2-x11 dbus ];

  # components build is supposed to be run along with release, but for whatever
  # reason it doesn't
  buildPhase = ''
    substituteInPlace build.sh --replace "\$(which lazbuild)" "'lazbuild --lazarusdir=${lazarus}/share/lazarus'"
    ./build.sh components
    ./build.sh release
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp ./doublecmd $out/bin/doublecmd
  '';

  meta = with lib; {
    homepage    = "https://doublecmd.sourceforge.io";
    description = "Open source file manager with two panels side by side";
    license     = licenses.gpl2;
    platforms   = platforms.linux;
  };
}
