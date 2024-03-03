{
  inputs,
  config,
  lib,
  ...
}:

{
  networking.hostName = "desktop";
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-amd" ];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  imports = [
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    ../modules/base
    ../modules/virtualization
    ../modules/terminal
    ../modules/hyprland
    inputs.home-manager.nixosModules.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
    }
  ];
}
