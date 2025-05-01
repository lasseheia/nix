{
  microvm.vms.router = {
    config = {
      system.stateVersion = "24.05";
      networking.hostName = "router";
      systemd.network.enable = true;
      users.users.root.password = "test123";
      services.openssh = {
        enable = true;
        settings.PermitRootLogin = "yes";
      };
      microvm = {
        shares = [{
          source = "/nix/store";
          mountPoint = "/nix/.ro-store";
          tag = "ro-store";
          proto = "virtiofs";
        }];
        interfaces = [
          {
            type = "tap";
            id = "vm-router";
            mac = "02:00:00:00:00:01";
          }
        ];
      };
    };
  };
}
