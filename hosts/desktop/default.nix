{ pkgs, inputs, pkgs-unstable, ... }:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
    ../../modules/nixos
    ../../modules/home-manager
    ../../modules/virtualization
    ../../modules/terminal
    ../../modules/neovim
    ../../modules/git
    ../../modules/flox
    ../../modules/hyprland
    ../../modules/podman
  ];

  environment.systemPackages = [
    pkgs.prusa-slicer
    pkgs-unstable.azuredatastudio
    pkgs-unstable.rustdesk-flutter
    pkgs-unstable.firefox
    pkgs.signal-desktop
    pkgs-unstable.krita
    pkgs-unstable.opentabletdriver
    pkgs-unstable.orca-slicer
    pkgs-unstable.blender
    pkgs-unstable.sqlcmd
    pkgs-unstable.cura-appimage
  ];
}
