{
  networking = {
    firewall = {
      allowedTCPPorts = [ 8123 ];
    };
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/home-assistant/config 0755 root root -"
  ];

  virtualisation.oci-containers = {
    backend = "podman";
    containers.home-assistant = {
      image = "homeassistant/home-assistant:stable";
      autoStart = true;
      extraOptions = [
        "--network=host"
        "--device=/dev/ttyACM0"
      ];
      ports = [ "8123:8123" ];
      environment = {
        TZ = "Europe/Oslo";
      };
      volumes = [
        "/var/lib/home-assistant/config:/config"
      ];
    };
  };
}
