{ pkgs, pkgs-unstable, ... }:

{
  home.packages = [
    pkgs.kitty
    pkgs.neofetch
    pkgs.tldr
    pkgs.tree
    pkgs.jq
    pkgs.yq-go
    pkgs.kubectl
    (pkgs.azure-cli.withExtensions [ pkgs.azure-cli.extensions.k8s-extension ])
    pkgs.kubelogin
    pkgs.yarn
    pkgs.age
    pkgs.kubeseal
    pkgs.fluxcd
    pkgs.ipcalc
    pkgs.act
    pkgs.openssl
    pkgs.openconnect
    pkgs.killall
    (pkgs.nerdfonts.override {
      fonts = [
        "FiraCode"
        "DroidSansMono"
        "Hack"
        "SourceCodePro"
      ];
    })
    pkgs.k9s
    pkgs-unstable.terraform
  ];

  services.ssh-agent.enable = if pkgs.stdenv.isDarwin then false else true;

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
      icons = true;
      git = true;
      extraOptions = [ "--group-directories-first" ];
    };

    zoxide = {
      enable = true;
      options = [ "--cmd cd" ];
    };

    fzf.enable = true;

    bat.enable = true;

    kitty = {
      enable = true;
      theme = "GitHub Dark Dimmed";
      settings = {
        background_opacity = "0.8";
      };
    };

    zellij.enable = true;

    starship = {
      enable = true;
      settings.add_newline = false;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    git = {
      enable = true;
      userName = "Lasse Heia";
      userEmail = "23742718+lasseheia@users.noreply.github.com";
      extraConfig = {
        pull = {
          rebase = true;
        };
        commit.gpgsign = true;
        commit.verbose = true;
        gpg.format = "ssh";
        user.signingkey = "~/.ssh/id_ed25519.pub";
        rerere.enabled = true;
        column.ui = "auto";
        branch.sort = "-committerdate";
        core.pager = "bat";
        maintenance.auto = true;
        core.untrackedcache = true;
        core.fsmonitor = true;
      };
    };

    gh = {
      enable = true;
      settings = {
        version = 1;
      };
    };

    # Workaround for https://github.com/NixOS/nixpkgs/issues/169115
    gh.gitCredentialHelper.enable = false;
    git.extraConfig.credential = {
      "https://github.com" = {
        helper = "!gh auth git-credential";
      };
      "https://gist.github.com" = {
        helper = "!gh auth git-credential";
      };
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
