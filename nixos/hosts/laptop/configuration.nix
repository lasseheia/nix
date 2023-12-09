{ config, pkgs, ... }:

{
  services.lvm.enable = true;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  sound.enable = true;
  hardware.opengl.enable = true;
  
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

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.firefox.enable = true;
}
