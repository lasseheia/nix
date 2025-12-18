{ pkgs, ... }:

{
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      autoPrune.enable = true;
    };
  };
  users.users.lasse.extraGroups = [ "podman" ];
  environment.systemPackages = [
    pkgs.podman-compose
  ];
}
