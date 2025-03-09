{ modulesPath, ...}:

{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  users.users.nixos = {
    isNormalUser = true;
    home = "/home/nixos";
    extraGroups = [ "wheel" ]; # Allows sudo access if needed
  };

  systemd.tmpfiles.rules = [
    "d /home/nixos 0755 nixos users -"
    "f /home/nixos/install.sh 0755 nixos users - ${builtins.readFile ./scripts/install.sh}"
  ];

  console.keyMap = "no";

  networking.wireless = {
    enable = false;
    iwd.enable = true;
    networks."LH".psk = "grusom-kebab-saus-terje";
  };
}
