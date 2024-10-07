{
  description = "NixOS Flakes configuration";

  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";
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
  };

  outputs =
    inputs:
    let
      createSystem =
        hostname:
        inputs.nixpkgs-stable.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            { networking.hostName = "${hostname}"; }
            ./hosts/${hostname}.nix
          ];
          specialArgs = {
            inherit inputs;
          };
        };
    in
    {
      nixosConfigurations = {
        desktop = createSystem "desktop";
        laptop = createSystem "laptop";
      };
      darwinConfigurations = {
        lasseheiamacbook = inputs.nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [ ./hosts/macbook.nix ];
          specialArgs = {
            inherit inputs;
          };
        };
      };
    };
}
