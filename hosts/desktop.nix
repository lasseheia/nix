{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:

let
  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit (config.nixpkgs) system;
    config.allowUnfree = true;
  };
in
{
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
  ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-amd" ];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  imports = [
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    ../modules/nixos
    ../modules/virtualization
    ../modules/terminal
    ../modules/neovim
    ../modules/git
    ../modules/hyprland
  ];

  environment.systemPackages = [
    pkgs.prusa-slicer
    pkgs.openscad
    pkgs-unstable.azuredatastudio
    pkgs-unstable.rustdesk-flutter
    pkgs-unstable.rpi-imager
  ];
}
