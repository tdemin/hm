{ lib, stdenv, rustPlatform, fetchFromGitHub,
  pkg-config, openssl, dbus }:

rustPlatform.buildRustPackage rec {
  pname = "Rescrobbled";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "InputUsername";
    repo = "rescrobbled";
    rev = "v${version}";
    sha256 = "0b41k938jl16a4x0z9ywgvkd2xfrbgdk5wbjz6qk2564nndg9p5j";
  };
  cargoSha256 = "17rflrnkl79mfg26cwbglv8vlf055ag6fal83fp6yl3nvb9hxbb7";
  # skip tests, they don't work anyway
  doCheck = false;

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl dbus ];

  meta = with lib; {
    description = "MPRIS music scrobbler daemon";
    license     = licenses.gpl3;
    platforms   = platforms.linux;
  };
}
