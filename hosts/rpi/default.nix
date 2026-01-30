{ pkgs, inputs, ... }:
let
  ssh_keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH8V+W2mKUj8QpWJe5N8Z6zrekUISHwdXy6vp4nkte4l" ];
in
{
  imports = [
    inputs.home-manager.nixosModules.default
    ../../modules/terminal
    ../../modules/git
    ../../modules/neovim
  ];

  networking = {
    hostName = "rpi";
    wireless = {
      iwd.enable = true;
    };
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

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.lasse = {
      programs.home-manager.enable = true;
      home = {
        stateVersion = "23.05";
        username = "lasse";
        homeDirectory = "/home/lasse";
      };
      wayland.windowManager.sway.enable = true;
      wayland.windowManager.sway.config.modifier = "Super";
    };
  };

  programs.sway.enable = true;

  environment.systemPackages = with pkgs; [
    brave
  ];
}
