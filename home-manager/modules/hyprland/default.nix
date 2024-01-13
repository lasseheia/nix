{ pkgs, ... }:

{
  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "hyprland";
  };

  home.packages = with pkgs; [
    swww
    lxqt.lxqt-policykit
    wl-clipboard # for cliphist
  ];

  services.dunst.enable = true;

  programs.wofi = {
    enable = true;
    settings = {
      show = "drun";
      width = 750;
      height = 400;
      always_parse_args = true;
      show_all = false;
      print_command = true;
      insensitive = true;
      prompt = "Hmm, what do you want to run?";
    };
    style = ''
      /* Latte Sky */
      @define-color accent #04a5e5;
      @define-color txt #4c4f69;
      @define-color bg #eff1f5;
      @define-color bg2 #bcc0cc;
      
       * {
          font-family: 'JetBrains Mono Nerd Font', monospace;
          font-size: 14px;
       }
      
       /* Window */
       window {
          margin: 0px;
          padding: 10px;
          border: 3px solid @accent;
          border-radius: 7px;
          background-color: @bg;
          animation: slideIn 0.5s ease-in-out both;
       }
      
       /* Slide In */
       @keyframes slideIn {
          0% {
             opacity: 0;
          }
      
          100% {
             opacity: 1;
          }
       }
      
       /* Inner Box */
       #inner-box {
          margin: 5px;
          padding: 10px;
          border: none;
          background-color: @bg;
          animation: fadeIn 0.5s ease-in-out both;
       }
      
       /* Fade In */
       @keyframes fadeIn {
          0% {
             opacity: 0;
          }
      
          100% {
             opacity: 1;
          }
       }
      
       /* Outer Box */
       #outer-box {
          margin: 5px;
          padding: 10px;
          border: none;
          background-color: @bg;
       }
      
       /* Scroll */
       #scroll {
          margin: 0px;
          padding: 10px;
          border: none;
       }
      
       /* Input */
       #input {
          margin: 5px;
          padding: 10px;
          border: none;
          color: @accent;
          background-color: @bg2;
          animation: fadeIn 0.5s ease-in-out both;
       }
      
       /* Text */
       #text {
          margin: 5px;
          padding: 10px;
          border: none;
          color: @txt;
          animation: fadeIn 0.5s ease-in-out both;
       }
      
       /* Selected Entry */
       #entry:selected {
         background-color: @accent;
       }
      
       #entry:selected #text {
          color: @bg;
       }
    '';
  };

  services.cliphist.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ",highres,auto,1,bitdepth,10"; # https://github.com/hyprwm/xdg-desktop-portal-hyprland/issues/99#issuecomment-1731390092
      exec-once = [
        "swww init && swww img /home/lasse/Downloads/e6631e9c-1718-435e-a37f-899482313bfe.webp"
        "waybar"
        "dunst"
        "lxqt-policykit-agent"
        "wl-paste --watch cliphist store"
      ];
      "$mod" = "SUPER";
      input = {
        kb_layout = "no";
      };
      bind = [
        "$mod, R, exec, wofi --show run"
        "$mod, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"
        "$mod, Return, exec, kitty"
        "$mod, Q, killactive"
        "$mod, M, exit"
        "$mod, F, fullscreen"

        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"

        "$mod CTRL, h, resizeactive, 15% 0"
        "$mod CTRL, l, resizeactive, -15% 0"
        "$mod CTRL, k, resizeactive, 0 -15%"
        "$mod CTRL, j, resizeactive, 0 15%"

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
