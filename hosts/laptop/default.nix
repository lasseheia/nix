{ pkgs-unstable, ... }:

{
  imports = [
    ../../modules/nixos
    ../../modules/home-manager
    ../../modules/terminal
    ../../modules/neovim
    ../../modules/git
    ../../modules/hyprland
  ];

  environment.systemPackages = [
    pkgs-unstable.rustdesk-flutter
  ];
}
