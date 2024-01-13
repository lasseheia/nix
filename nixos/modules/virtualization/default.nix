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
}
