{ pkgs, ... }:

{
  home.packages = with pkgs; [
    brave
  ];

  home.sessionVariables = {
    BROWSER = "brave";
  };
}
