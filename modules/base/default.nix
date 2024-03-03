{ pkgs, lib, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.05";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.optimise.automatic = true;
  nix.settings.auto-optimise-store = true;

  services.lvm.enable = true;

  networking = {
    wireless.iwd.enable = true;
    firewall = {
      enable = true;
    };
  };

  time.timeZone = "Europe/Oslo";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "nb_NO.UTF-8";
    };
  };

  security.polkit.enable = true;

  home-manager.users.lasse = ./home-manager.nix;
}
