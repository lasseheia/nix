{ pkgs, lib, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Limit the number of generations to keep
  boot.loader.systemd-boot.configurationLimit = 10;

  # Install the latest linux kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/nvme0n1p2";
      preLVM = true;
      allowDiscards = true;
    };
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/nvme0n1p1";
      fsType = "vfat";
    };
    "/" = {
      device = "/dev/vg/root";
      fsType = "ext4";
    };
    "/home" = {
      device = "/dev/vg/home";
      fsType = "ext4";
    };
  };

  swapDevices = [ ];

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

  # https://nixos.wiki/wiki/Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  home-manager.users.lasse = ./home-manager.nix;
}
