{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-generators, ... }:
  let
    system = "x86_64-linux";
  in
  {
    packages.${system} = {
      incus-rootfs = nixos-generators.nixosGenerate {
        system = system;
        format = "lxc";
        modules = [ ./default.nix ];
      };

      incus-metadata = nixos-generators.nixosGenerate {
        system = system;
        format = "lxc-metadata";
        modules = [ ./default.nix ];
      };

      nixosConfigurations.home-assistant = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./default.nix ];
      };
    };
  };
}
