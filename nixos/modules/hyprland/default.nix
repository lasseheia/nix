{ pkgs, ... }:

{
  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
    };
  };

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };

  # https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    enableNvidiaPatches = true;
  };

  # https://wiki.hyprland.org/Useful-Utilities/Screen-Sharing/#prerequisites
  environment.systemPackages = [
    pkgs.xwaylandvideobridge
  ];
}
