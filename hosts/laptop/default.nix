{ config, inputs, ... }:

let
  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit (config.nixpkgs) system;
    config.allowUnfree = true;
  };
in
{
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "nvme"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-intel" ];

  imports = [
    inputs.nixos-hardware.nixosModules.dell-latitude-7490
    ../../modules/nixos
    ../../modules/terminal
    ../../modules/neovim
    ../../modules/git
    ../../modules/flox
    ../../modules/hyprland
  ];

  environment.systemPackages = [
    pkgs-unstable.rustdesk-flutter
  ];
}
