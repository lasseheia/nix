{
  programs.home-manager.enable = true;

  home.stateVersion = "23.05";
  home.username = "lasse";
  home.homeDirectory = "/home/lasse";

  imports = [
    ./modules/terminal
  ];
}
