{
  networking.firewall.allowedTCPPorts = [ 25600 ];

  systemd.tmpfiles.rules = [
    "d /var/lib/komga/config 0755 1000 1000 -"
    "d /var/lib/komga/data 0755 1000 1000 -"
  ];

  virtualisation.oci-containers = {
    backend = "podman";
    containers.komga = {
      image = "gotson/komga:latest";
      autoStart = true;
      user = "1000:1000";
      ports = [ "25600:25600" ];
      volumes = [
        "/var/lib/komga/config:/config"
        "/var/lib/komga/data:/data"
      ];
    };
  };
}
