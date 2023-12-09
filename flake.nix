{
  description = "NixOS Flakes configuration";

  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
        modules = [
          {
            networking.hostName = "desktop";
          }
          nixos-hardware.nixosModules.common-pc
          nixos-hardware.nixosModules.common-pc-ssd
          nixos-hardware.nixosModules.common-cpu-amd
          ./nixos/modules/amd
          ./nixos/modules/luks
          ./nixos/modules/lvm
          ./nixos/base
          ./nixos/modules/boot
          ./nixos/hosts/desktop
          ./nixos/modules/nvidia
          ./nixos/modules/hyprland
          ./nixos/modules/steam
          ./nixos/modules/lutris
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.lasse = {
              imports = [
                ./home-manager/base
                ./home-manager/modules/hyprland
                ./home-manager/modules/waybar
                ./home-manager/modules/browser
              ];
            };
          }
        ];
      };
      laptop = nixpkgs.lib.nixosSystem {
        modules = [
          {
            networking.hostName = "laptop";
          }
          ./nixos/base
          ./nixos/hosts/laptop
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.lasse = {
              imports = [
                ./home-manager/base
                ./home-manager/modules/hyprland
                ./home-manager/modules/waybar
                ./home-manager/modules/browser
              ];
            };
          }
        ];
      };
    };
  };
}

