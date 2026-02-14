{
  system.stateVersion = "26.05";

  console.keyMap = "no";
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };
  users.users.root = {
    isNormalUser = false;
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH8V+W2mKUj8QpWJe5N8Z6zrekUISHwdXy6vp4nkte4l" ];
  };

  services.k3s = {
    enable = true;
    extraFlags = [ "--tls-san=10.0.0.171" ];
  };
  networking.firewall.allowedTCPPorts = [ 6443 ];
}
