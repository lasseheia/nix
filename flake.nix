{
  description = "NixOS Flakes configuration";

  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

    nix-darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvirt = {
      url = "https://flakehub.com/f/AshleyYakeley/NixVirt/*.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    let
      createSystem = hostname:
        inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            { networking.hostName = "${hostname}"; }
            ./hosts/${hostname}.nix
          ];
          specialArgs = { inherit inputs; };
        };
    in {
    nixosConfigurations = {
      desktop = createSystem "desktop";
      laptop  = createSystem "laptop";
    };
    darwinConfigurations = {
      lasseheiamacbook = inputs.nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [ ./hosts/macbook.nix ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}
