let
  ssh_keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH8V+W2mKUj8QpWJe5N8Z6zrekUISHwdXy6vp4nkte4l" ];
in
{
  nix.settings.experimental-features = "nix-command flakes";

  system.stateVersion = "24.11";
  console.keyMap = "no";

  networking = {
    wireless.iwd.enable = true;
    hostName = "server";
    firewall = {
      enable = true;
    };
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  users.users = {
    root = {
      isNormalUser = false;
      openssh.authorizedKeys.keys = ssh_keys;
    };
    lasse = {
      isNormalUser = true;
      home = "/home/lasse";
      openssh.authorizedKeys.keys = ssh_keys;
      extraGroups  = [ "wheel" ];
    };
  };

  networking.nftables.enable = true;
  virtualisation.incus = {
    enable = true;
    agent.enable = true;
    ui.enable = true;
    preseed = {
      config = {
        "core.https_address" = ":8443";
      };
    };
  };
  networking.firewall.allowedTCPPorts = [ 8443 ];
}
