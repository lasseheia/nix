{ inputs, ... }:

{
  networking = {
    hostName = "rpi";
    wireless = {
      iwd.enable = true;
    };
    firewall = {
      enable = true;
    };
  };

  services.openssh.enable = true;
  console.keyMap = "no";

  users.users.lasse = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  imports = [
    inputs.home-manager.nixosModules.default
    ../../modules/homebridge
    ../../modules/home-assistant
    ../../modules/mainsail
    ../../modules/prometheus
    ../../modules/grafana
    ../../modules/pi-hole
    ../../modules/jellyfin
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.lasse = {
    home.stateVersion = "24.05";
  };
}
