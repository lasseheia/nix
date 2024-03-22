{
  pkgs,
  ...
}:

{
  console = {
    earlySetup = true;
    keyMap = "no";
    font = "ter-i16b";
    packages = with pkgs; [
      terminus_font
    ];
  };

  programs.zsh.enable = true;

  programs.git.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.lasse = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };

  home-manager.users.lasse = ./home-manager.nix;
}
