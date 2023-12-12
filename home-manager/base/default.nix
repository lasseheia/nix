{ pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.stateVersion = "23.05";
  home.username = "lasse";
  home.homeDirectory = "/home/lasse";

  home.packages = with pkgs; [
    openssl
    openconnect
    signal-desktop
  ];

  imports = [
    ../modules/terminal
  ];
}
