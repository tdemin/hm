{
    lib, stdenv, fetchFromGitHub, makeWrapper,
    age, coreutils
}:

stdenv.mkDerivation rec {
    pname = "akm";
    version = "v0.1.0";

    src = fetchFromGitHub {
        owner = "tdemin";
        repo = "akm";
        rev = "4a2a38ca967478ef6ab20d9d1591160aa66ea9c7";
        sha256 = sha256:2ihUCUMJzM6WVgDguKBsPktuvdE1VVqx3QQW2OcLW84=;
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
