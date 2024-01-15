{
  description = "NixOS Flakes configuration";

  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    hyprland.url = "github:hyprwm/Hyprland/v0.34.0";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixos-hardware,
    nixpkgs,
    home-manager,
    hyprland,
    ...
  }: {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          {
            networking.hostName = "desktop";
            boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" ];
            boot.initrd.kernelModules = [ "dm-snapshot" ];
            boot.kernelModules = [ "kvm-amd" ];
          }
          nixos-hardware.nixosModules.common-pc
          nixos-hardware.nixosModules.common-pc-ssd
          nixos-hardware.nixosModules.common-cpu-amd
          ./nixos/modules/amd-cpu
          ./nixos/modules/luks
          ./nixos/modules/lvm
          ./nixos/base
          ./nixos/modules/boot
          ./nixos/modules/nvidia
          ./nixos/modules/virtualization
          ./nixos/modules/hyprland
          ./nixos/modules/obs
          ./nixos/modules/steam
          ./nixos/modules/lutris
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.lasse = {
              imports = [
                ./home-manager/base
                ./home-manager/modules/hyprland
                ./home-manager/modules/waybar-desktop
                ./home-manager/modules/browser
              ];
            };
          }
        ];
      };
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          {
            networking.hostName = "laptop";
            boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
            boot.initrd.kernelModules = [ "dm-snapshot" ];
            boot.kernelModules = [ "kvm-intel" ];
          }
          nixos-hardware.nixosModules.dell-latitude-7490
          ./nixos/modules/luks
          ./nixos/modules/lvm
          ./nixos/base
          ./nixos/modules/boot
          ./nixos/modules/bluetooth
          ./nixos/modules/hyprland
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.lasse = {
              imports = [
                ./home-manager/base
                ./home-manager/modules/hyprland
                ./home-manager/modules/waybar-laptop
                ./home-manager/modules/browser
              ];
            };
          }
        ];
      };
    };
  };
}

