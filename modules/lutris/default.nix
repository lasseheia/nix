{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lutris
    wine # https://github.com/lutris/docs/blob/master/WineDependencies.md
  ];
  hardware.opengl.driSupport32Bit = true; # https://nixos.wiki/wiki/Lutris - Also enabled in `modules/steam.nix`
}
