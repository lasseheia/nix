{ pkgs, ... }:

{
  programs.git.enable = true;

  environment.systemPackages = [
    pkgs.pre-commit
  ];

  home-manager.users.lasse = ./home-manager.nix;
}
