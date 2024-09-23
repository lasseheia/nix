{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    skhd
  ];

  services.yabai = {
    enable = true;
    extraConfig = builtins.readFile ./yabairc;
  };

  services.skhd = {
    enable = true;
    skhdConfig = builtins.readFile ./skhdrc;
  };
}
