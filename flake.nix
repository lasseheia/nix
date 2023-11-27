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
    self,
    nixpkgs,
    home-manager,
    hyprland,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    nixosConfigurations = {
      nixos-orange = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
        };
	      modules = [
	        ./hardware-configuration.nix
	        ./configuration.nix
        ];
      };
    };
    homeConfigurations = {
      "lasse@nixos-orange" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
        modules = [
          ./home.nix
        ];
      };
    };
  };
}
