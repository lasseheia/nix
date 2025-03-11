{ inputs, ... }:

{
  imports = [
    inputs.disko.nixosModules.disko
  ];

  disko.devices = {
    disk = {
      x = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "64M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
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
        mode = "single";  # Adjusted for a single-disk pool
        options.cachefile = "none";
        mountpoint = "none";
        rootFsOptions = {
          compression = "zstd";
          "com.sun:auto-snapshot" = "false";
        };
        postCreateHook = ''
          zfs list -t snapshot -H -o name | grep -E '^zroot@blank$' || zfs snapshot zroot@blank
        '';

        datasets = {
          ROOT = {
            type = "zfs_fs";
            mountpoint = "/";
          };
          home = {
            type = "zfs_fs";
            mountpoint = "/home";
          };
          var = {
            type = "zfs_fs";
            mountpoint = "/var";
          };
          nix = {
            type = "zfs_fs";
            mountpoint = "/nix";
          };
          zfs_fs = {
            type = "zfs_fs";
            mountpoint = "/zfs_fs";
            options."com.sun:auto-snapshot" = "true";
          };
          zfs_unmounted_fs = {
            type = "zfs_fs";
            options.mountpoint = "none";
          };
          zfs_legacy_fs = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            mountpoint = "/zfs_legacy_fs";
          };
          zfs_volume = {
            type = "zfs_volume";
            size = "10M";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/ext4onzfs";
            };
          };
          zfs_volume_no_content = {
            type = "zfs_volume";
            size = "10M";
          };
          zfs_encryptedvolume = {
            type = "zfs_volume";
            size = "10M";
            options = {
              encryption = "aes-256-gcm";
              keyformat = "passphrase";
              keylocation = "file:///tmp/secret.key";
            };
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/ext4onzfsencrypted";
            };
          };
          encrypted = {
            type = "zfs_fs";
            options = {
              mountpoint = "none";
              encryption = "aes-256-gcm";
              keyformat = "passphrase";
              keylocation = "file:///tmp/secret.key";
            };
          };
          "encrypted/test" = {
            type = "zfs_fs";
            mountpoint = "/zfs_crypted";
          };
          swap = {
            type = "zfs_volume";
            size = "2G";  # Adjust swap size as needed
          };
        };
      };
    };
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/nvme0n1p1";  # Boot partition on nvme0n1
      fsType = "vfat";
    };
    "/" = {
      device = "zroot/ROOT";
      fsType = "zfs";
    };
    "/home" = {
      device = "zroot/home";
      fsType = "zfs";
    };
    "/var" = {
      device = "zroot/var";
      fsType = "zfs";
    };
    "/nix" = {
      device = "zroot/nix";
      fsType = "zfs";
    };
  };

  swapDevices = [
    { device = "/dev/zvol/zroot/swap"; }
  ];

  boot.supportedFilesystems = [ "zfs" ];
  boot.initrd.supportedFilesystems = [ "zfs" ];

  services.zfs.autoScrub.enable = true;

  networking.hostId = "b648d918";
}
