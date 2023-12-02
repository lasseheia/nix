{ pkgs, ... }:

{
  # https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    enableNvidiaPatches = true;
  };

  # https://wiki.hyprland.org/Useful-Utilities/Screen-Sharing/#prerequisites
  services.pipewire.enable = true;
  services.pipewire.wireplumber.enable = true;
  environment.systemPackages = [
    pkgs.xwaylandvideobridge
  ];
}
