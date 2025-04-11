{ pkgs, inputs, modulesPath, ...}:

{
  imports = [
    #inputs.disko.nixosModules.disko
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  nix.settings.experimental-features = "nix-command flakes";

  environment.systemPackages = [
    pkgs.tmux
  ];

  #boot.loader.systemd-boot.enable = true;
  #disko.devices = {
  #  disk = {
  #    main = {
  #      device = "/dev/sda";
  #      type = "disk";
  #      content = {
  #        type = "gpt";
  #        partitions = {
  #          ESP = {
  #            type = "EF00";
  #            size = "500M";
  #            content = {
  #              type = "filesystem";
  #              format = "vfat";
  #              mountpoint = "/boot";
  #              mountOptions = [ "umask=0077" ];
  #            };
  #          };
  #          root = {
  #            size = "100%";
  #            content = {
  #              type = "filesystem";
  #              format = "ext4";
  #              mountpoint = "/";
  #            };
  #          };
  #        };
  #      };
  #    };
  #  };
  #};

  networking.wireless = {
    enable = false;
    iwd.enable = true;
  };

  services.openssh = {
    enable = true;
    # require public key authentication for better security
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    #settings.PermitRootLogin = "yes";
  };

  users.users.nixos.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH8V+W2mKUj8QpWJe5N8Z6zrekUISHwdXy6vp4nkte4l"
  ];

  environment.etc."install.sh" = {
    source = ./scripts/install.sh;
    mode = "0755";
  };

  console.keyMap = "no";
}
