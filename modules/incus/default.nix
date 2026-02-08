{ pkgs, ... }:
{
  networking.nftables.enable = true;
  virtualisation.incus = {
    enable = true;
    package = pkgs.incus; # Default is pkgs.incusStable
    agent.enable = true;
    ui.enable = true;
    preseed = {
      config = {
        "core.https_address" = ":8443";
      };
    };
  };
  networking.firewall.allowedTCPPorts = [ 8443 ];
  networking.firewall.interfaces.incusbr0.allowedTCPPorts = [ 53 67 ];
  networking.firewall.interfaces.incusbr0.allowedUDPPorts = [ 53 67 ];
  security.apparmor.enable = true;
}
