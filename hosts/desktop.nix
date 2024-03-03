{ inputs, ... }:

{
  networking.hostName = "desktop";
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-amd" ];

  imports = [
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    ../nixos/modules/amd-cpu
    ../nixos/modules/luks
    ../nixos/modules/lvm
    ../nixos/base
    ../nixos/modules/boot
    ../nixos/modules/steam
    ../nixos/modules/lutris
    inputs.home-manager.nixosModules.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.lasse = {
        imports = [
          ../home-manager/base
          ../home-manager/modules/browser
        ];
      };
    }
    ../modules/virtualization
    ../modules/hyprland
  ];
}
