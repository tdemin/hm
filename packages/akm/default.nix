{
    lib, stdenv, fetchFromGitHub, makeWrapper,
    age, coreutils
}:

stdenv.mkDerivation rec {
    pname = "akm";
    version = "v0.3.0";

    src = fetchFromGitHub {
        owner = "tdemin";
        repo = "akm";
        rev = "3eb495c561e15f4e653080e1986a419bd270d5f9";
        sha256 = sha256:Rk81IlTjZ3O30Aj5q38XlrD7aiog3wHVxHq8TT9FQGw=;
    };

    nativeBuildInputs = [ makeWrapper ];
    wrapperPath = with lib; makeBinPath [ age ];

    dontBuild = true;
    installPhase = ''
        ${coreutils}/bin/install -D -m 0755 akm $out/bin/akm
    '';
    fixupPhase = ''
        patchShebangs $out/bin
        wrapProgram $out/bin/akm --prefix PATH : "${wrapperPath}"
    '';

    meta = with lib; {
        description = "age key manager";
        license = licenses.mit;
        homepage = "https://github.com/tdemin/akm";
        platforms = platforms.unix;
    };
}
