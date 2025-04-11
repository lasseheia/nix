{
  networking = {
    firewall = {
      allowedTCPPorts = [ 80 ];
    };
  };

#  systemd.tmpfiles.rules = [
#    "d /var/lib/mainsail 0755 1000 1000 -"
#  ];

  virtualisation.oci-containers = {
    backend = "podman";
    containers.mainsail = {
      image = "ghcr.io/mainsail-crew/mainsail:latest";
      autoStart = true;
#      user = "1000:1000";
      extraOptions = [
        "--network=host"
      ];
      ports = [ "80:80" ];
      environment = {
        TZ = "Europe/Oslo";
      };
#      volumes = [
#        "/var/lib/mainsail:/usr/share/nginx/html"
#      ];
    };
  };
}
