{ inputs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.dell-latitude-7490
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "nvme"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-intel" ];

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
}
