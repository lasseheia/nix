{ pkgs, pkgs-unstable, ... }:

{
  home.packages = [
    pkgs.jq
    pkgs.yq-go
    pkgs.yarn
    pkgs.ipcalc
    pkgs.killall
    (pkgs.nerdfonts.override {
      fonts = [
        "FiraCode"
        "DroidSansMono"
        "Hack"
        "SourceCodePro"
      ];
    })
  ];

  xdg.configFile."zellij/config.kdl" = {
    source = ./zellij.kdl;
  };

  programs = {

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      initExtra = builtins.readFile ./zshrc;
      oh-my-zsh = {
        enable = true;
      };
    };

    atuin.enable = true;

    eza = {
      enable = true;
      enableZshIntegration = true;
      icons = "auto";
      git = true;
      extraOptions = [ "--group-directories-first" ];
    };

    zoxide = {
      enable = true;
      options = [ "--cmd cd" ];
    };

    fzf.enable = true;

    bat.enable = true;

    alacritty = {
      enable = true;
      settings = {
        window = {
          opacity = 0.8;
          option_as_alt = "OnlyLeft";
          decorations = "None";
        };
        selection = {
          save_to_clipboard = true;
        };
        font = {
          normal = {
            family = "FiraCode Nerd Font";
            style = "Regular";
          };
        };
      };
    };

    zellij.enable = true;

    starship = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      settings = {
        add_newline = false;
        azure = {
          disabled = false;
        };
        kubernetes = {
          disabled = false;
          symbol = "⎈ ";
        };
      };
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    yazi = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
