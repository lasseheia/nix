{
 pkgs ? import <nixpkgs> {}
}:

pkgs.stdenv.mkDerivation {
  name = "bicep-ls";
  src = pkgs.fetchurl {
    url = "https://github.com/Azure/bicep/releases/download/v0.25.53/bicep-langserver.zip";
    sha256 = "b3d58475b2761c66c9bd7df233e5f4c5a3c99dd9f5f82e84f4d1d5459e9dca4b";
  };
  nativeBuildInputs = [ pkgs.unzip ];
  unpackPhase = "unzip $src -d $out";
  installPhase = ''
    mkdir -p $out/bin
    cp -r . $out/bin/bicep-langserver
  '';
  dontBuild = true;
}
