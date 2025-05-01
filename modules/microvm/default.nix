{ inputs, ... }:

{
  systemd.network = {
    netdevs."10-microvm".netdevConfig = {
      Kind = "bridge";
      Name = "microvm";
    };
    networks = {
      microvm = {
        matchConfig.Name = "microvm";
        networkConfig = {
          DHCPServer = true;
          IPv6SendRA = true;
        };
        addresses = [{
          addressConfig.Address = "10.0.0.1/24";
        }
          {
            addressConfig.Address = "fd12:3456:789a::1/64";
          }];
        ipv6Prefixes = [{
          ipv6PrefixConfig.Prefix = "fd12:3456:789a::/64";
        }];
      };
      microvm-eth0 = {
        matchConfig.Name = "vm-*";
        networkConfig.Bridge = "microvm";
      };
    };
  };


  networking.nat = {
    enable = true;
    enableIPv6 = true;
    externalInterface = "wlan0";
    internalInterfaces = [ "microvm" ];
  };

  imports = [
    inputs.microvm.nixosModules.host
    ./vms/router
  ];
}
