{ nixos-hardware, home-manager, ... }:
{
  networking.hostName = "laptop";
  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-intel" ];

  imports = [
    nixos-hardware.nixosModules.dell-latitude-7490
    ../nixos/modules/luks
    ../nixos/modules/lvm
    ../nixos/base
    ../nixos/modules/boot
    ../nixos/modules/bluetooth
    ../nixos/modules/hyprland
    home-manager.nixosModules.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.lasse = {
        imports = [
          ../home-manager/base
          ../home-manager/modules/hyprland
          ../home-manager/modules/waybar-laptop
          ../home-manager/modules/browser
        ];
      };
    }
  ];
}
