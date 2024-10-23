{
  pkgs,
  inputs,
  ...
}:

{
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    initrd.availableKernelModules = [ "xhci_pci" "usbhid" "usb_storage" ];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };

  hardware.enableRedistributableFirmware = true;
  system.stateVersion = "24.05";
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

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
    ../modules/homebridge
    ../modules/home-assistant
  ];
  
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.lasse = {
    home.stateVersion = "24.05";
  };
}
