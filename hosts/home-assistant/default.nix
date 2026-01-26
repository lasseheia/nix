{ pkgs, ... }:

{
  boot.isContainer = true;
  system.stateVersion = "25.11";

  nix.settings.experimental-features = "nix-command flakes";
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
  users.users.lasse.isNormalUser = true;
  users.groups.lasse = {};
  users.users.lasse.group = "lasse";
  users.users.lasse.openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH8V+W2mKUj8QpWJe5N8Z6zrekUISHwdXy6vp4nkte4l" ];

  networking.useDHCP = true;

  time.timeZone = "Europe/Oslo";

  services.home-assistant = {
    enable = true;
    openFirewall = true;
    config = {
      homeassistant = {
        name = "Home";
        time_zone = "Europe/Oslo";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    curl
    vim
  ];
}
