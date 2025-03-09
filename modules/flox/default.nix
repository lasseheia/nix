{ inputs, pkgs, ... }:

{
  environment.systemPackages = [
    inputs.flox.packages.${pkgs.system}.default
  ];

  nix.settings = {
    substituters = [
      "https://cache.flox.dev"
    ];
    trusted-public-keys = [
      "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="
    ];
  };
}
