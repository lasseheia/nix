{
  imports = [
    ../../modules/nixos
  ];

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/nvme0n1p2";  # Encrypted root partition
      allowDiscards = true;  # Enable TRIM for SSDs/NVMe
    };
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/nvme0n1p1";  # Boot partition
      fsType = "vfat";
    };
    "/" = {
      device = "rpool/root/nixos";  # ZFS root dataset
      fsType = "zfs";
    };
    "/home" = {
      device = "rpool/root/home";  # ZFS home dataset
      fsType = "zfs";
    };
    "/var" = {
      device = "rpool/root/var";  # ZFS var dataset
      fsType = "zfs";
    };
    "/nix" = {
      device = "rpool/root/nix";  # ZFS nix dataset
      fsType = "zfs";
    };
  };

  swapDevices = [
    { device = "/dev/zvol/rpool/swap"; }  # ZFS swap volume
  ];

  boot.supportedFilesystems = [ "zfs" ];
  boot.initrd.supportedFilesystems = [ "zfs" ];

  #services.zfs.autoScrub.enable = true;

  networking.hostId = "b648d918";  # Randomly generated host ID

  users.users.lasse.isNormalUser = true;

  users.users.lasse.group = "lasse";
  users.groups.lasse = {};
}
