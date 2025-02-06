{
  networking = {
    firewall = {
      allowedTCPPorts = [ 8080 ];
    };
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/mainsail 0755 root root -"
  ];

  virtualisation.oci-containers = {
    backend = "podman";
    containers.mainsail = {
      image = "ghcr.io/mainsail-crew/mainsail:latest";
      autoStart = true;
      extraOptions = [
        "--network=host"
      ];
      ports = [ "8080:80" ];
      environment = {
        TZ = "Europe/Oslo";
      };
      volumes = [
        "/var/lib/mainsail:/usr/share/nginx/html"
      ];
    };
  };
}
