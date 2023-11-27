{
  description = "NixOS Flakes configuration";

  inputs = {
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
    nixpkgs,
    home-manager,
    hyprland,
    ...
  }@inputs: {
    nixosConfigurations = {
      nixos-orange = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	specialArgs = { inherit inputs; };
	modules = [
	  ./hardware-configuration.nix
	  ./configuration.nix

	  hyprland.nixosModules.default {
	    programs.hyprland.enable = true;
	  }

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.lasse = import ./home.nix;
          }
        ];
      };
    };
    homeConfigurations."lasse@nixos-orange" = home-manager.lib.homeManagerConfiguration {
      modules = [
        hyprland.homeManagerModules.default
        {wayland.windowManager.hyprland.enable = true;}
      ];
    };
  };
}
