{
  imports = [
    ./hardware-configuration.nix
  ];

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
}
