{ pkgs, inputs, ... }:

let
  image = pkgs.fetchurl {
    url = "https://github.com/home-assistant/operating-system/releases/download/16.3/haos_ova-16.3.qcow2.xz";
    sha256 = "sha256-8/VsrnLNwXMsNbGyp1R6ETl+qqyMTeL/Y7sQ9FchyM4=";
    downloadToTemp = true;
    postFetch = ''
      ${pkgs.xz}/bin/xz --decompress $downloadedFile
    '';
  };
in
{
  imports = [
    inputs.nixvirt.nixosModules.default
  ];

  users.users.lasse.extraGroups = [ "libvirtd" ];

  virtualisation.libvirt = {
    enable = true;
    swtpm.enable = true;
    package = pkgs.libvirt;
  };

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      ovmf.enable = true;
      ovmf.packages = [ pkgs.OVMFFull.fd ];
      swtpm.enable = true;
    };
    allowedBridges = [ "virbr0" ];
  };

  systemd.services."libvirt-guests" = {
    enable = false;
    unitConfig.Mask = true;
  };

  virtualisation.libvirt.connections = {
    "qemu:///system" = {
      domains = [
        {
          definition = inputs.nixvirt.lib.domain.writeXML (inputs.nixvirt.lib.domain.templates.linux
          {
            name = "haos";
            uuid = "cc7439ed-36af-4696-a6f2-1f0c4474d87e";
            memory = { count = 6; unit = "GiB"; };
            #storage_vol = image;
            storage_vol = {
              type = "file";
              path = image;
              device = "disk";
              driver = {
                name = "qemu";
                type = "qcow2";
              };
            };
            #storage_vol = {
            #  pool = "default";
            #  volume = "haos-disk1.qcow2";
            #};
            #backing_vol = image;
          });
        }
      ];
      networks = [
        {
          definition = ./network.xml;
          active = true;
        }
      ];
    };
  };

  networking = {
    firewall = {
      allowedTCPPorts = [ 8123 ];
    };
  };
}
