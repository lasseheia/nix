{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

#  fileSystems."/" =
#    { device = "/dev/disk/by-uuid/0472188d-eccc-4260-b0b5-c109ac285d9e";
#      fsType = "ext4";
#    };
#
#  fileSystems."/home" =
#    { device = "/dev/disk/by-uuid/62d5f266-8a31-44cf-a3d9-4ab3040d17f2";
#      fsType = "ext4";
#    };
#
  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/5AFB-1FD8";
      fsType = "vfat";
    };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
