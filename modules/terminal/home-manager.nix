{
  pkgs,
  ...
}:

let
  bicep-ls = pkgs.callPackage ../../pkgs/bicep-ls.nix { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    kitty
    neofetch
    tldr
    tree
    jq
    yq-go
    kubectl
    azure-cli
    kubelogin
    bitwarden-cli
    yarn
    sweethome3d.application
    flutter
    nodePackages.typescript
    age
    hugo
    rustc
    cargo
    kubeseal
    fluxcd
    ipcalc
    act
    openssl
    openconnect
    killall
    terraform
    nodejs # Required for nvim-copilot
    ripgrep # For nvim-telescope
    fd # For nvim-telescope
    tree-sitter # For nvim-treesitter
    gcc # For nvim-lspconfig
    terraform-ls # For nvim-lspconfig
    typescript # For nvim-lspconfig
    nixd # For nvim-lspconfig
    nodePackages.typescript-language-server # For nvim-lspconfig
    yaml-language-server # For nvim-lspconfig
    dotnet-sdk_8 # For bicep-ls
    bicep-ls
  ];

  services.ssh-agent.enable = true;

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    initExtra = builtins.readFile ./zshrc;
    shellAliases = {
      ll = "ls -lah";
    };
  };

  services.copyq.enable = true;

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [
      "--cmd cd"
    ];
  };

  programs.kitty = {
    enable = true;
    theme = "GitHub Dark Dimmed";
    settings = {
      background_opacity = "0.8";
    };
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
    extraConfig = builtins.readFile ./tmux.conf;
  };

  programs.starship = {
    enable = true;
    settings.add_newline = false;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
    userName = "Lasse Heia";
    userEmail = "23742718+lasseheia@users.noreply.github.com";
    extraConfig = {
      pull = {
        rebase = true;
      };
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/id_ed25519.pub";
      rerere.enabled = true;
      column.ui = "auto";
      branch.sort = "-committerdate";
      core.pager = "cat";
      maintenance.auto = true;
      core.untrackedcache = true;
      core.fsmonitor = true;
    };
  };

  programs.gh.enable = true;

  # Workaround for https://github.com/NixOS/nixpkgs/issues/169115
  programs.gh.gitCredentialHelper.enable = false;
  programs.git.extraConfig.credential = {
    "https://github.com" = {
      helper = "!gh auth git-credential";
    };
    "https://gist.github.com" = {
      helper = "!gh auth git-credential";
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraConfig = builtins.readFile ./neovim/vimrc;
    extraLuaConfig = ''
      local bicep_lsp_bin = "${bicep-ls}/Bicep.LangServer.dll"
    '' + builtins.readFile ./neovim/init.lua;
    plugins = with pkgs.vimPlugins;
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
      in [
      {
        plugin = copilot-vim;
      }
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
      #{
      #  plugin = auto-session;
      #  type = "lua";
      #  config = builtins.readFile ./neovim/plugins/auto-session.lua;
      #}
    ] ++ telescope ++ cmp;
  };
}
