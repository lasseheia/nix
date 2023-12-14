{ pkgs, ... }:

{
  home.packages = with pkgs; [
    swww
    bemenu
    lxqt.lxqt-policykit
  ];

  services.dunst.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ",highres,auto,1,bitdepth,10"; # https://github.com/hyprwm/xdg-desktop-portal-hyprland/issues/99#issuecomment-1731390092
      exec-once = [
        "waybar"
        "swww init"
        "dunst"
        "lxqt-policykit-agent"
      ];
      exec = "swww img /home/lasse/_MG_2485-mod_APOD.jpg";
      "$mod" = "SUPER";
      input = {
        kb_layout = "no";
      };
      bind = [
        "$mod, Return, exec, kitty"
        "$mod, Q, killactive"
        "$mod, M, exit"
        "$mod, R, exec, bemenu-run -p 'Run:'"
        "$mod, F, fullscreen"

        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"

        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, l, movewindow, r"
        "$mod SHIFT, k, movewindow, u"
        "$mod SHIFT, j, movewindow, d"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
      ];
    };
  };

  programs.zsh.initExtraFirst = ''
    [[ "$(tty)" = "/dev/tty1" ]] && exec Hyprland
  '';
}
