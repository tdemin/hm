{ lib, mkDerivation, fetchFromGitHub, cmake, extra-cmake-modules
, qtbase, qtscript, qtwebkit, libXfixes, libXtst, qtx11extras, git
, webkitSupport ? true
, knotifications, wayland, qtwayland, qtstyleplugins
}:

mkDerivation rec {
  pname = "CopyQ";
  version = "4.1.0";

  src = fetchFromGitHub {
    owner = "hluk";
    repo = "CopyQ";
    rev = "v${version}";
    sha256 = "kYrOW4KxYm/rGIbeShNkuuhJbXkiA+ScVLkC21KzTMU=";
  };

  nativeBuildInputs = [ cmake extra-cmake-modules ];

  buildInputs = [
    git qtbase qtscript libXfixes libXtst qtx11extras
    knotifications wayland qtwayland
  ] ++ lib.optional webkitSupport qtwebkit;

  meta = with lib; {
    homepage    = "https://hluk.github.io/CopyQ";
    description = "Clipboard Manager with Advanced Features";
    license     = licenses.gpl3;
    maintainers = [ maintainers.willtim ];
    # NOTE: CopyQ supports windows and osx, but I cannot test these.
    # OSX build requires QT5.
    platforms   = platforms.linux;
  };
}
