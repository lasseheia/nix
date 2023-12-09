{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    obs-studio
  ];

  boot = {
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    kernelModules = [ "v4l2loopback" ];
  };
}
