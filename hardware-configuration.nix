{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/94bb9b17-5de3-4f84-a196-67fa00dcc17f";
      preLVM = true;
      allowDiscards = true;
    };
  };
  
  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/5AFB-1FD8";
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
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
