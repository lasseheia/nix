{ pkgs, pkgs-unstable, ... }:

{
  home.username = "lasse";
  home.homeDirectory = "/home/lasse";

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  imports = [
    ../../modules/terminal/home-manager.nix
    ../../modules/git/home-manager.nix
    ../../modules/neovim/home-manager.nix
  ];

  home.packages = [
    pkgs.brave
    pkgs-unstable.zfs
  ];
}
