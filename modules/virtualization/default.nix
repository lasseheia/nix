{ pkgs, ... }:

{
  users.users.lasse.extraGroups = [
    "libvirtd"
    "docker"
  ];

  virtualisation.docker.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      swtpm.enable = true;
      ovmf.enable = true;
      ovmf.packages = [ pkgs.OVMFFull.fd ];
    };
  };

  programs.virt-manager.enable = true;
  services.spice-vdagentd.enable = true;

  # IOMMU
  boot.kernelParams = [ "amd_iommu=on" ];
  boot.blacklistedKernelModules = [ "nvidia" "nouveau" ];
  boot.kernelModules = [ "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];
  boot.extraModprobeConfig = "options vfio-pci ids=10de:1e84,10de:10f8,10de:1ad8,10de:1ad9";

  # Looking Glass
  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 1000 kvm -"
  ];

  home-manager.users.lasse = {
    programs.looking-glass-client.enable = true;
  };
}
