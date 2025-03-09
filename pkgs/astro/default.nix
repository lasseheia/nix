{ pkgs ? import <nixpkgs> { } }:

pkgs.stdenv.mkDerivation rec {
  pname = "astro-cli";
  version = "

    src = pkgs.fetchurl {
      url = " https://github.com/astronomer/astro-cli/releases/download/v$ { version }/astro_${version}_linux_amd64.tar.gz";
    sha256 = "0v1h7z5k6l8m9n2p3q4r5s6t7u8v9w0x1y2z3a4b5c6d7e8f9g0h1i2j3k4l5m6n"; # Replace with the actual SHA-256 hash
  };

  nativeBuildInputs = [ pkgs.makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    tar -xzf $src -C $out/bin --strip-components=1
    wrapProgram $out/bin/astro --set PATH ${pkgs.docker}/bin:$PATH
  '';
}

