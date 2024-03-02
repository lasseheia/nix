{
  nixos-hardware,
  home-manager,
  ...
}:

{
  networking.hostName = "desktop";
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-amd" ];

  imports = [
    nixos-hardware.nixosModules.common-pc
    nixos-hardware.nixosModules.common-pc-ssd
    nixos-hardware.nixosModules.common-cpu-amd
    ../nixos/modules/amd-cpu
    ../nixos/modules/luks
    ../nixos/modules/lvm
    ../nixos/base
    ../nixos/modules/boot
    ../nixos/modules/virtualization
    ../nixos/modules/hyprland
    ../nixos/modules/steam
    ../nixos/modules/lutris
    home-manager.nixosModules.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.lasse = {
        imports = [
          ../home-manager/base
          ../home-manager/modules/hyprland
          ../home-manager/modules/waybar-desktop
          ../home-manager/modules/browser
          ../home-manager/modules/virtualization
        ];
      };
    }
  ];
}
