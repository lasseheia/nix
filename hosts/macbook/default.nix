{ config
, inputs
, ...
}:
let
  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit (config.nixpkgs) system;
    config.allowUnfree = true;
  };
in
{
  imports = [
    inputs.home-manager.darwinModules.default
    ../../modules/yabai
  ];

  system.stateVersion = 4;
  nix.enable = false; # Required to use nix-darwin
  nix.package = pkgs-unstable.nix;
  nixpkgs.config.allowUnfree = true;
  nix.useDaemon = true;
  nix.settings.experimental-features = "nix-command flakes";

  networking = {
    hostName = "lasseheiamacbook";
    computerName = "Lasse Heia's MacBook";
  };

  programs.zsh.enable = true;

  users.users.lasse = {
    name = "lasse";
    home = "/Users/lasse";
  };

  environment.systemPackages = [
    pkgs-unstable.podman
    pkgs-unstable.flameshot
    pkgs-unstable.brave
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = { inherit pkgs-unstable; };
  home-manager.users.lasse = {
    home.stateVersion = "23.11";
    imports = [
      ../../modules/terminal/home-manager.nix
      ../../modules/neovim/home-manager.nix
      ../../modules/git/home-manager.nix
    ];
  };
}
