{
  description = "NixOS Flakes configuration";

  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    nixvirt = {
      url = "https://flakehub.com/f/AshleyYakeley/NixVirt/*.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    microvm = {
      url = "github:astro/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
  };

  outputs = inputs: let
    nixosConfiguration =
      hostname:
      system:
      inputs.nixpkgs-stable.lib.nixosSystem {
        system = system;
        modules = [
          { networking.hostName = "${hostname}"; }
          ./hosts/${hostname}
        ];
        specialArgs = { inherit inputs; };
      };
    darwinConfiguration =
      hostname:
      inputs.nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [ ./hosts/${hostname} ];
        specialArgs = { inherit inputs; };
      };
  in {
    nixosConfigurations = {
      desktop = nixosConfiguration "desktop" "x86_64-linux";
      laptop = nixosConfiguration "laptop" "x86_64-linux";
      rpi = nixosConfiguration "rpi" "aarch64-linux";
    };
    darwinConfigurations = {
      macbook = darwinConfiguration "macbook";
    };
  };
}
