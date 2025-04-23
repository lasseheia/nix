{ inputs, ... }:

let
  ssh_keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH8V+W2mKUj8QpWJe5N8Z6zrekUISHwdXy6vp4nkte4l" ];
in
{
  imports = [
    inputs.disko.nixosModules.disko
    ../../modules/home-assistant
    ../../modules/pi-hole
  ];

  networking.hostId = "b648d918"; # Randomly generated host ID, this is required for ZFS
  disko.devices = {
    disk = {
      nvme0n1 = {
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
                mountOptions = [ "nofail" ];  # Continue boot even if /boot fails to mount
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
          mountpoint = "none";  # Disable automatic mounting; set mountpoints per dataset below
          compression = "zstd"; # Efficient, modern compression
        };
        options.ashift = "12";  # Ensures proper 4K alignment for NVMe/SSD devices
        datasets = {
          "root" = {
            type = "zfs_fs";
            mountpoint = "/";
          };
          "root/home" = {
            type = "zfs_fs";
            mountpoint = "/home";
          };
          "root/nix" = {
            type = "zfs_fs";
            mountpoint = "/nix";
          };
          "root/swap" = {
            type = "zfs_volume";
            size = "2G";
            content = {
              type = "swap";
            };
            options = {
              volblocksize = "4096";  # Basic block size setting for swap
            };
          };
        };
      };
    };
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  system.stateVersion = "24.11";
  console.keyMap = "no";

  networking = {
    wireless.iwd.enable = true;
    hostName = "server";
    firewall = {
      enable = true;
    };
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  users.users = {
    root = {
      isNormalUser = false;
      openssh.authorizedKeys.keys = ssh_keys;
    };
    lasse = {
      isNormalUser = true;
      home = "/home/lasse";
      openssh.authorizedKeys.keys = ssh_keys;
      extraGroups  = [ "wheel" ];
    };
  };
}
