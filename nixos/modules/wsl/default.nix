{ config, lib, pkgs, inputs, outputs, ... }:

{
  imports = [
    <nixos-wsl/modules>
    inputs.home-manager.nixosModules.home-manager
  ];

  wsl.enable = true;
  wsl.defaultUser = "lasse";

  wsl.wslConf.network.generateResolvConf = false;
  networking.nameservers = [
    "1.1.1.1"
  ];
}
