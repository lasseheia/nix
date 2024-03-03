{ inputs, ... }:

{
  networking.hostName = "laptop";
  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-intel" ];

  imports = [
    inputs.nixos-hardware.nixosModules.dell-latitude-7490
    ../nixos/modules/luks
    ../nixos/modules/lvm
    ../nixos/modules/boot
    ../nixos/modules/bluetooth
    inputs.home-manager.nixosModules.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.lasse = {
        imports = [
          ../home-manager/modules/waybar-laptop
        ];
      };
    }
    ../modules/base
    ../modules/terminal
    ../modules/hyprland
  ];
}
