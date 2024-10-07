{
  config,
  pkgs,
  inputs,
  ...
}:
let
  unstablePkgs = import inputs.nixpkgs-unstable {
    inherit (config.nixpkgs) system;
    config.allowUnfree = true;
  };
in
{
  imports = [
    inputs.home-manager.darwinModules.default
    ../modules/yabai
  ];

  system.stateVersion = 4;
  nix.package = pkgs.nix;
  nixpkgs.config.allowUnfree = true;
  services.nix-daemon.enable = true;
  nix.settings.experimental-features = "nix-command flakes";

  programs.zsh.enable = true;

  users.users.lasse = {
    name = "lasse";
    home = "/Users/lasse";
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.lasse = {
    home.stateVersion = "23.11";
    imports = [ ../modules/terminal/home-manager.nix ];
  };

  environment.systemPackages = [
    unstablePkgs.terraform-ls # For nvim-lspconfig
    unstablePkgs.terraform
  ];
}
