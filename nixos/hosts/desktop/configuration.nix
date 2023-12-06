{ config, pkgs, ... }:

{
  system.stateVersion = "23.05";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;
  nixpkgs.config.allowUnfree = true;

  services.lvm.enable = true;

  networking = {
    hostName = "desktop";
    wireless.iwd.enable = true;
    firewall = {
      enable = true;
    };
  };
  
  time.timeZone = "Europe/Oslo";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "nb_NO.UTF-8";
    };
  };
  
  console = {
    earlySetup = true;
    keyMap = "no";
    font = "ter-i16b";
    packages = with pkgs; [
      terminus_font
    ];
  };
  fonts.packages = with pkgs; [
    nerdfonts
  ];

  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
    };
  };

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };

  programs.zsh.enable = true;

  programs.git.enable = true;
  
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.lasse = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };
}
