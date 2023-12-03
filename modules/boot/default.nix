{ pkgs, ... }:

{
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Limit the number of generations to keep
  boot.loader.systemd-boot.configurationLimit = 10;

  # Install the latest linux kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
}

