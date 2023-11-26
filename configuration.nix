# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.initrd.luks.devices = {
    "root" = {
      device = "/dev/disk/by-label/boot";
      preLVM = true;
      allowDiscards = true;
    };
  };

  boot.initrd.lvm = {
    enable = true;
  };

  fileSystems."/" = {
    device = "/dev/vg/root";
    fsType = "ext4";
  };
  fileSystems."/home" = {
    device = "/dev/vg/home";
    fsType = "ext4";
  };
 
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "23.05";
  
  networking = {
    hostName = "nixos-orange";
    wireless.iwd.enable = true;
    firewall = {
      enable = true;
    };
  };
  
  sound.enable = true;
  hardware.opengl.enable = true;
  
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

  nixpkgs.config.allowUnfree = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.waybar.enable = true;

  programs.zsh = {
    enable = true;
    loginShellInit = ''
      if [ "$(tty)" = "/dev/tty1" ]; then
        exec Hyprland
      fi
    '';
    shellInit = ''
      bindkey '^P' up-history
      bindkey '^N' down-history
    '';
  };

  programs.starship.enable = true;

  programs.tmux.enable = true;

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

