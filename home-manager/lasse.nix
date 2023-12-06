{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;
  
  home.stateVersion = "23.05";
  home.username = "lasse";
  home.homeDirectory = "/home/lasse";

  home.packages = with pkgs; [
    brave
    discord
  ];

  home.sessionVariables = {
    BROWSER = "brave";
  };
}
