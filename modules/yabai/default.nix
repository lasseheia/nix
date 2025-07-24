{
  services.yabai = {
    enable = true;
    extraConfig = builtins.readFile ./yabairc;
  };

  services.skhd = {
    enable = true;
    skhdConfig = builtins.readFile ./skhdrc;
  };

  services.sketchybar = {
    enable = true;
    config = builtins.readFile ./sketchybarrc;
  };
}
