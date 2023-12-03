{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;
  
  home.stateVersion = "23.05";
  home.username = "lasse";
  home.homeDirectory = "/home/lasse";

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ",highres,auto,1";
      exec-once = [
        "waybar"
        "swww init"
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

  services.dunst.enable = true;

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        modules-left = [
          "custom/right-arrow-dark"
        ];
        modules-center = [
          "custom/left-arrow-dark"
          "clock#1"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "clock#2"
          "custom/right-arrow-dark"
          "custom/right-arrow-light"
          "clock#3"
          "custom/right-arrow-dark"
        ];
        modules-right = [
          "custom/left-arrow-dark"
          "pulseaudio"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "memory"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "cpu"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "disk"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "tray"
        ];
        "custom/left-arrow-dark" = {
          format = "";
          tooltip = false;
        };
        "custom/left-arrow-light" = {
          "format" = "";
          "tooltip" = false;
        };
        "custom/right-arrow-dark" = {
          "format" = "";
          "tooltip" = false;
        };
        "custom/right-arrow-light" = {
          "format" = "";
          "tooltip" = false;
        };

        "clock#1" = {
          "format" = "{:%a}";
          "tooltip" = false;
        };
        "clock#2" = {
          "format" = "{:%H:%M}";
          "tooltip" = false;
        };
        "clock#3" = {
          "format" = "{:%m-%d}";
          "tooltip" = false;
        };

        "pulseaudio" = {
          "format" = "{icon} {volume:2}%";
          "format-bluetooth" = "{icon}  {volume}%";
          "format-muted" = "MUTE";
          "format-icons" = {
            "headphones" = "";
            "default" = [
              ""
              ""
            ];
          };
          "scroll-step" = 5;
          "on-click" = "pamixer -t";
          "on-click-right" = "pavucontrol";
        };
        "memory" = {
          "interval" = 5;
          "format" = "Mem {}%";
        };
        "cpu" = {
          "interval" = 5;
          "format" = "CPU {usage:2}%";
        };
        "disk" = {
          "interval" = 5;
          "format" = "Disk {percentage_used:2}%";
          "path" = "/";
        };
        "tray" = {
          "icon-size" = 20;
        };
      };
    };
    style = ''
      * {
        font-size: 12px;
        font-family: monospace;
        margin: 0px 5px;
      }

      window#waybar {
        background: #292b2e;
        color: #fdf6e3;
      }

      #custom-right-arrow-dark,
      #custom-left-arrow-dark {
        color: #1a1a1a;
      }
      #custom-right-arrow-light,
      #custom-left-arrow-light {
        color: #292b2e;
        background: #1a1a1a;
      }

      #workspaces,
      #clock.1,
      #clock.2,
      #clock.3,
      #pulseaudio,
      #memory,
      #cpu,
      #disk,
      #tray {
        background: #1a1a1a;
      }

      #workspaces button {
        padding: 0 2px;
        color: #fdf6e3;
      }
      #workspaces button.focused {
        color: #268bd2;
      }
      #workspaces button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
      }
      #workspaces button:hover {
        background: #1a1a1a;
        border: #1a1a1a;
        padding: 0 3px;
      }

      #pulseaudio {
        color: #268bd2;
      }
      #memory {
        color: #2aa198;
      }
      #cpu {
        color: #6c71c4;
      }
      #disk {
        color: #b58900;
      }

      #clock,
      #pulseaudio,
      #memory,
      #cpu,
      #disk {
        padding: 0 10px;
      }
    '';
  };

  services.pasystray.enable = true;
  
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    initExtraFirst = ''
      [[ "$(tty)" = "/dev/tty1" ]] && exec Hyprland
    '';
    initExtra = ''
      [[ -z "$TMUX" ]] && tmux
    '';
    shellAliases = {
      ll = "ls -lah";
    };
  };

  programs.kitty = {
    enable = true;
    theme = "GitHub Dark Dimmed";
  };
  
  programs.starship = {
    enable = true;
    settings.add_newline = false;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    newSession = true;
    clock24 = true;
    baseIndex = 1;
    prefix = "C-a";
    keyMode = "vi";
    escapeTime = 10;
    extraConfig = ''
      # Reload configuration
      bind r source-file ~/.config/tmux/tmux.conf

      # Split panes
      bind | split-window -h
      bind - split-window -v
      
      # Switch panes
      bind -n M-a select-pane -L
      bind -n M-d select-pane -R
      bind -n M-w select-pane -U
      bind -n M-s select-pane -D

      # Styling
      ## Statusbar
      set -g status-style bg=black,fg=white
      set -g window-status-current-style bg=blue,bold
      set -g status-right '#[fg=colour39]#(cut -d " " -f 1-3 /proc/loadavg)#[default] #[fg=white]%H:%M#[default]'
    '';
  };
  
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      colorscheme slate
      set number
      set relativenumber 
      set numberwidth=1
      highlight LineNr ctermfg=White
      set mouse=
      set autoindent
      set tabstop=2
      set shiftwidth=2
      set softtabstop=2
      set smarttab
      set smartcase
      set expandtab
      set encoding=utf-8
    '';
  };

  programs.git = {
    enable = true;
    userName = "Lasse Heia";
    userEmail = "23742718+lasseheia@users.noreply.github.com";
    extraConfig = {
      pull = {
        rebase = true;
      };
      credential = { # https://github.com/NixOS/nixpkgs/issues/169115
        "https://github.com" = {
          helper = "!gh auth git-credential";
        };
        "https://gist.github.com" = {
          helper = "!gh auth git-credential";
        };
      };
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = false; # https://github.com/NixOS/nixpkgs/issues/169115
  };

  home.packages = with pkgs; [
    swww
    kitty
    bemenu
    neofetch
    brave
    tldr
    tree
    jq
    discord
  ];

  home.sessionVariables = {
    BROWSER = "brave";
  };
}
