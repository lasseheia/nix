{ config, pkgs, ... }:

{
  home.stateVersion = "23.05";
  home.username = "lasse";
  home.homeDirectory = "/home/lasse";
  
  programs.home-manager.enable = true;
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = "waybar";
      "$mod" = "SUPER";
      input = {
        kb_layout = "no";
      };
      bind = [
        "$mainMod, Return, exec, kitty"
        "$mainMod, Q, killactive"
        "$mainMod, M, exit"
        "$mainMod, R, exec, bemenu-run -p 'Run:'"
        "$mainMod, F, fullscreen"

        "bind = $mainMod, h, move, l"
        "bind = $mainMod, l, move, r"
        "bind = $mainMod, k, move, u"
        "bind = $mainMod, j, move, d"

        "bind = $mainMod, h, movefocus, l"
        "bind = $mainMod, l, movefocus, r"
        "bind = $mainMod, k, movefocus, u"
        "bind = $mainMod, j, movefocus, d"

        "bind = $mainMod, 1, workspace, 1"
        "bind = $mainMod, 2, workspace, 2"
        "bind = $mainMod, 3, workspace, 3"
        "bind = $mainMod, 4, workspace, 4"
        "bind = $mainMod, 5, workspace, 5"
        "bind = $mainMod, 6, workspace, 6"
        "bind = $mainMod, 7, workspace, 7"
        "bind = $mainMod, 8, workspace, 8"
        "bind = $mainMod, 9, workspace, 9"
        "bind = $mainMod, 0, workspace, 10"

        "bind = $mainMod SHIFT, 1, movetoworkspace, 1"
        "bind = $mainMod SHIFT, 2, movetoworkspace, 2"
        "bind = $mainMod SHIFT, 3, movetoworkspace, 3"
        "bind = $mainMod SHIFT, 4, movetoworkspace, 4"
        "bind = $mainMod SHIFT, 5, movetoworkspace, 5"
        "bind = $mainMod SHIFT, 6, movetoworkspace, 6"
        "bind = $mainMod SHIFT, 7, movetoworkspace, 7"
        "bind = $mainMod SHIFT, 8, movetoworkspace, 8"
        "bind = $mainMod SHIFT, 9, movetoworkspace, 9"
        "bind = $mainMod SHIFT, 0, movetoworkspace, 10"
      ];
    };
  };

  programs.waybar = {
    enable = true;
#    settings = {};
    style = ''
      * {
          border: none;
          border-radius: 0;
          font-family: Roboto, Helvetica, Arial, sans-serif;
          font-size: 13px;
          min-height: 0;
      }
      
      window#waybar {
          background: rgba(43, 48, 59, 0.5);
          border-bottom: 3px solid rgba(100, 114, 125, 0.5);
          color: white;
      }
      
      tooltip {
        background: rgba(43, 48, 59, 0.5);
        border: 1px solid rgba(100, 114, 125, 0.5);
      }
      tooltip label {
        color: white;
      }
      
      #workspaces button {
          padding: 0 5px;
          background: transparent;
          color: white;
          border-bottom: 3px solid transparent;
      }
      
      #workspaces button.focused {
          background: #64727D;
          border-bottom: 3px solid white;
      }
      
      #mode, #clock, #battery {
          padding: 0 10px;
      }
      
      #mode {
          background: #64727D;
          border-bottom: 3px solid white;
      }
    '';
  };
  
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    initExtra = "[[ -z \"$TMUX\" ]] && tmux";
    shellAliases = {
      ll = "ls -lah";
    };
    zsh-abbr = {
      enable = true;
      abbreviations = {
        k = "kubectl";
      };
    };
  };

  programs.starship = {
    enable = true;
    settings.add_newline = false;
  };
  
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      colorscheme slate
      set relativenumber 
      set numberwidth=1
      highlight LineNr ctermfg=White
      
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
  
  programs.git = {
    enable = true;
    userName = "Lasse Heia";
    userEmail = "23742718+lasseheia@users.noreply.github.com";
    extraConfig = {
      credential = { # https://github.com/NixOS/nixpkgs/issues/169115
        "https://github.com" = {
          helper = "!gh auth git-credential";
        };
      };
      credential = { # https://github.com/NixOS/nixpkgs/issues/169115
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
    kitty
    bemenu
    brave
    tldr
  ];

  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/http" = "brave.desktop";
  };
  
}
