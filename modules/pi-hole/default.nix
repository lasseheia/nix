{
  networking = {
    firewall = {
      allowedTCPPorts = [
        53
        80
      ];
      allowedUDPPorts = [
        53
        67
      ];
    };
  };

  virtualisation.oci-containers = {
    backend = "podman";
    containers.pihole = {
      image = "pihole/pihole:latest";
      autoStart = true;
      extraOptions = [
        "--network=host"
        "--cap-add=NET_ADMIN"
      ];
      ports = [
        "53:53/tcp"
        "53:53/udp"
        "67:67/udp"
        "80:80/tcp"
      ];
      environment = {
        TZ = "America/Chicago";
        WEBPASSWORD = "your_secure_password";
      };
      volumes = [
        "/var/lib/pihole:/etc/pihole"
        "/var/lib/dnsmasq:/etc/dnsmasq.d"
      ];
    };
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/pihole 0755 root root -"
    "d /var/lib/dnsmasq 0755 root root -"
  ];
}
