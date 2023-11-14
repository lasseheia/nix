# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  system.copySystemConfiguration = true;
  system.stateVersion = "23.05";
  
  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "nixos-orange";
    wireless.iwd.enable = true;
    firewall = {
      enable = true;
    };
  };
  
  sound.enable = true;
  hardware = {
    pulseaudio.enable = true;
    opengl.enable = true;
  };
  
  time.timeZone = "Europe/Oslo";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    earlySetup = true;
    keyMap = "no";
    font = "ter-i16b";
    packages = with pkgs; [
      terminus_font
    ];
  };
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-emoji
  ];

  nixpkgs.config.allowUnfree = true;
  programs = {
    hyprland.enable = true;
    waybar.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    git = {
      enable = true;
      config = {
        user.name = "Lasse Heia";
	user.email = "23742718+lasseheia@users.noreply.github.com";
      };
    };
    zsh = {
      enable = true;
      loginShellInit = "if [ \"$(tty)\" = \"/dev/tty1\" ]; then exec Hyprland; fi";
      shellInit = ''
        bindkey '^P' up-history
        bindkey '^N' down-history
      '';
      shellAliases = {
        ll = "ls -la";
      };
      #autosuggestions.enable = true;
    };
    starship = {
      enable = true;
      settings = {
        add_newline = false;
        username = {
          style_user = "bright-white bold";
          style_root = "bright-red bold";
        };
        hostname = {
          ssh_only = true;
          format = "[$ssh_symbol](bold blue) on [$hostname](bold red) ";
          trim_at = ".companyname.com";
          disabled = false;
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    kitty
    wofi
    brave
    gh
  ];

# This did not work to set the default browser for opening urls from the terminal
#  xdg.mime.defaultApplications = {
#    "text/html" = ["brave.desktop"];
#  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.lasse = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };

}

