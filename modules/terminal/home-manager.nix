{ pkgs, pkgs-unstable, ... }:

let
  bicep-ls = pkgs.callPackage ../../pkgs/bicep-ls.nix { inherit pkgs; };
in
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
    pkgs.nodejs # Required for nvim-copilot
    pkgs.ripgrep # For nvim-telescope and nvim-spectre
    pkgs.fd # For nvim-telescope
    pkgs.tree-sitter # For nvim-treesitter
    pkgs.gcc # For nvim-lspconfig
    pkgs.typescript # For nvim-lspconfig
    pkgs.nixd # For nvim-lspconfig
    pkgs.nodePackages.typescript-language-server # For nvim-lspconfig
    pkgs.yaml-language-server # For nvim-lspconfig
    pkgs.dotnet-sdk_8 # For bicep-ls
    (pkgs.nerdfonts.override {
      fonts = [
        "FiraCode"
        "DroidSansMono"
        "Hack"
        "SourceCodePro"
      ];
    })
    pkgs.k9s
    bicep-ls
    pkgs-unstable.terraform
    pkgs-unstable.terraform-ls # For nvim-lspconfig
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

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      extraConfig = builtins.readFile ./neovim/vimrc;
      extraLuaConfig =
        ''
          local bicep_lsp_bin = "${bicep-ls}/Bicep.LangServer.dll"
        ''
        + builtins.readFile ./neovim/init.lua;
      plugins =
        with pkgs.vimPlugins;
        let
          cmp = [
            {
              plugin = nvim-cmp;
              type = "lua";
              config = builtins.readFile ./neovim/plugins/nvim-cmp.lua;
            }
            cmp-nvim-lsp
            cmp-buffer
            cmp-path
            cmp-cmdline
            nvim-cmp
            cmp-vsnip
            vim-vsnip
          ];
          telescope = [
            {
              plugin = telescope-nvim;
              type = "lua";
              config = builtins.readFile ./neovim/plugins/telescope-nvim.lua;
            }
            nvim-treesitter
          ];
          searchbox = [
            {
              plugin = searchbox-nvim;
              type = "lua";
              config = builtins.readFile ./neovim/plugins/searchbox-nvim.lua;
            }
            nui-nvim
          ];
        in
        [
          { plugin = diffview-nvim; }
          { plugin = copilot-vim; }
          {
            plugin = nvim-tree-lua;
            type = "lua";
            config = builtins.readFile ./neovim/plugins/nvim-tree-lua.lua;
          }
          {
            plugin = nvim-lspconfig;
            type = "lua";
            config = builtins.readFile ./neovim/plugins/nvim-lspconfig.lua;
          }
          {
            plugin = nvim-spectre;
            type = "lua";
            config = builtins.readFile ./neovim/plugins/nvim-spectre.lua;
          }
          #{
          #  plugin = auto-session;
          #  type = "lua";
          #  config = builtins.readFile ./neovim/plugins/auto-session.lua;
          #}
        ]
        ++ telescope
        ++ cmp
        ++ searchbox;
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
