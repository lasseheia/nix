{
  networking = {
    hostName = "rpi";
    wireless = {
      iwd.enable = true;
    };
    firewall = {
      enable = true;
    };
  };

  services.openssh.enable = true;
  console.keyMap = "no";

  users.users.lasse = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}
