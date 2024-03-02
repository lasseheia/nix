{
  pkgs,
  ...
}:

{
  imports = [ ./nixos.nix ];
  home-manager.users.lasse = ./home-manager.nix;
}
