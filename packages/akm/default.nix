{
    lib, stdenv, fetchFromGitHub, makeWrapper,
    age, coreutils
}:

stdenv.mkDerivation rec {
    pname = "akm";
    version = "v0.3.1";

    src = fetchFromGitHub {
        owner = "tdemin";
        repo = "akm";
        rev = "${version}";
        sha256 = sha256:zOZl0yHxGB12ajs+ZgZ03ao3fllVzanoR2UVkSvMl6w=;
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
