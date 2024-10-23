{ pkgs, ... }:

{
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
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
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # https://wiki.hyprland.org/Useful-Utilities/Screen-Sharing/#prerequisites
  environment.systemPackages = [ pkgs.xwaylandvideobridge ];

  services.blueman.enable = true;

  home-manager.users.lasse = ./home-manager.nix;
}
