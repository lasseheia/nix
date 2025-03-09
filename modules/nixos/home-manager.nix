{ lib, ... }:

{
  programs.home-manager.enable = true;

  home.stateVersion = "23.05";
  home.username = "lasse";
  home.homeDirectory = lib.mkDefault "/home/lasse";
}
