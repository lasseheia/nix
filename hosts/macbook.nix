{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.home-manager.darwinModules.default
  ];

  system.stateVersion = 4;
  nix.package = pkgs.nix;
  nixpkgs.config.allowUnfree = true;
  services.nix-daemon.enable = true;
  nix.settings.experimental-features = "nix-command flakes";

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    neovim
    yabai
  ];

  users.users.lasse = {
    name = "lasse";
    home = "/Users/lasse";
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.lasse = { pkgs, ... }: {
    home.stateVersion = "23.11";
    imports = [
      ../modules/terminal/home-manager.nix
    ];
  };
}
