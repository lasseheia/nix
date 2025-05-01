{ inputs, ... }:

{
  imports = [
    inputs.microvm.nixosModules.microvm

    {
      system.stateVersion = "24.05";
      systemd.network.enable = true;
      networking.hostName = "router";
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
            id = "vm-test1";
            mac = "02:00:00:00:00:01";
          }
        ];
      };
    }
  ];
}
