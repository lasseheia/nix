{ pkgs, inputs, pkgs-unstable, config, lib, ... }:

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
    inputs.disko.nixosModules.disko
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
    pkgs-unstable.rpi-imager
    pkgs-unstable.firefox
    pkgs.signal-desktop
    pkgs-unstable.krita
    pkgs-unstable.opentabletdriver
  ];

  hardware.opentabletdriver = {
    enable = true;
    package = pkgs-unstable.opentabletdriver;
  };

  networking.hostId = "b648d919"; # Randomly generated host ID, required for ZFS

  disko.devices = {
    disk = {
      root = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "nofail" ];
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          };
        };
      };
    };
    zpool = {
      zroot = {
        type = "zpool";
        rootFsOptions = {
          mountpoint = "none";
          compression = "zstd";
          acltype = "posixacl";
          xattr = "sa";
          "com.sun:auto-snapshot" = "true";
        };
        options.ashift = "12";
        datasets = {
          "root" = {
            type = "zfs_fs";
            options = {
              encryption = "aes-256-gcm";
              keyformat = "passphrase";
              keylocation = "prompt";
            };
            mountpoint = "/";

          };
          "root/nix" = {
            type = "zfs_fs";
            options.mountpoint = "/nix";
            mountpoint = "/nix";
          };

          "root/swap" = {
            type = "zfs_volume";
            size = "10M";
            content = {
              type = "swap";
            };
            options = {
              volblocksize = "4096";
              compression = "zle";
              logbias = "throughput";
              sync = "always";
              primarycache = "metadata";
              secondarycache = "none";
              "com.sun:auto-snapshot" = "false";
            };
          };
        };
      };
    };
  };
}
