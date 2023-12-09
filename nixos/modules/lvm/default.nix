{
  fileSystems = {
    "/boot" = {
      device = "/dev/nvme0n1p1";
      fsType = "vfat";
    };
    "/" = {
      device = "/dev/vg/root";
      fsType = "ext4";
    };
    "/home" = {
      device = "/dev/vg/home";
      fsType = "ext4";
    };
  };

  swapDevices = [ ];
}
