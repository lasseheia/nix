{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = inputs:
    {
      nixosConfigurations.rpi = inputs.nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./default.nix
          ./hardware-configuration.nix
        ];
        specialArgs = {
          inherit inputs;
        };
      };
    };
}
