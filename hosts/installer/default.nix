{ modulesPath, ...}:

{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  environment.etc."install.sh" = {
    source = ./scripts/install.sh;
    mode = "0755";
  };

  console.keyMap = "no";

  networking.wireless = {
    enable = false;
    iwd.enable = true;
  };
}
