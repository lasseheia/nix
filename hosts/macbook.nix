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
  services.nix-daemon.enable = true;
  nix.settings.experimental-features = "nix-command flakes";

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    neovim
    yabai
  ];
}