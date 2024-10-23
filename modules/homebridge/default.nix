{
  networking = {
    firewall = {
      allowedTCPPorts = [ 8581 ];
    };
  };

  environment.etc."homebridge/config.json".text = builtins.readFile ./config.json;

  systemd.tmpfiles.rules = [
    "d /var/lib/homebridge 0755 root root -"
    "L /var/lib/homebridge/config.json - - - - /etc/homebridge/config.json"
  ];

  virtualisation.oci-containers = {
    backend = "podman";
    containers.homebridge = {
      image = "homebridge/homebridge@sha256:db80af156aaefc621d5442e4b056388826a625fa2da0d8e36c429698bf949fc0"; # 2024-10-09
      autoStart = true;
      extraOptions = [
        "--network=host"
#        "--device=/dev/ttyACM0"
      ];
      ports = [ "8581:8581" ];
      environment = {
        TZ = "Europe/Oslo";
      };
      volumes = [
        "/var/lib/homebridge:/homebridge"
      ];
    };
  };
}
