{
  description = "NixOS Flakes configuration";

  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs:
    let
      createSystem = hostname:
        inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./hosts/${hostname}.nix ];
          specialArgs = { inherit inputs; };
        };
    in {
    nixosConfigurations = {
      desktop = createSystem "desktop";
      laptop  = createSystem "laptop";
    };
  };
}
