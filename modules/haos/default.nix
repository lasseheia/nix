{ pkgs, inputs, ... }:

let
  image = pkgs.fetchurl {
    url = "https://github.com/home-assistant/operating-system/releases/download/16.3/haos_ova-16.3.qcow2.xz";
    sha256 = "sha256-8/VsrnLNwXMsNbGyp1R6ETl+qqyMTeL/Y7sQ9FchyM4=";
    downloadToTemp = true;
    postFetch = ''
      ${pkgs.xz}/bin/xz -d $downloadedFile
    '';
  };
in
{
  imports = [
    inputs.nixvirt.nixosModules.default
  ];

  users.users.lasse.extraGroups = [ "libvirtd" ];

  networking = {
    firewall = {
      allowedTCPPorts = [ 8123 ];
    };
  };

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

  systemd.tmpfiles.rules = [
    "d /var/lib/libvirt/haos 0755 root root -"
  ];

  system.activationScripts.prepareHaos = {
    text = ''
      if [ ! -f /var/lib/libvirt/haos/haos.qcow2 ]; then
        cp ${image}/haos.qcow2 /var/lib/libvirt/haos/haos.qcow2
      fi
    '';
  };

  systemd.services."libvirt-guests" = {
    enable = false;
    unitConfig.Mask = true;
  };

  virtualisation.libvirt.connections = {
    "qemu:///system" = {
      domains = [
        {
          definition = ./domain.xml;
          active = true;
          restart = true;
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
}
