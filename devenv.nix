{ pkgs, ... }:

{
  packages = [
    pkgs.age
  ];

  git-hooks.hooks = {
    nixpkgs-fmt.enable = true;
    deadnix.enable = true;
  };
}
