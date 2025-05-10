{ pkgs-unstable, ... }:

{
  imports = [
    ../../modules/nixos
    ../../modules/home-manager
    ../../modules/terminal
    ../../modules/flox
    ../../modules/neovim
    ../../modules/git
    ../../modules/flox
    ../../modules/hyprland
  ];

  environment.systemPackages = [
    pkgs-unstable.rustdesk-flutter
  ];
}
