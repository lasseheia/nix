{ pkgs, ... }:

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

  services.kubernetes = {
    roles = [ "master" "node" ];
    masterAddress = "localhost";
    apiserverAddress = "https://localhost:8080";
    easyCerts = true;
    kubelet.extraOpts = "--fail-swap-on=false";
    apiserver = {
      enable = true;
      securePort = 8080;
    };
    addons.dns.enable = true;
  };

  environment.systemPackages = with pkgs; [
    kubectl
  ];
}
