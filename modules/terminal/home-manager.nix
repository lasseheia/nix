{ pkgs, ... }:

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
    terraform-ls # For nvim-lspconfig
    typescript # For nvim-lspconfig
    nodePackages.typescript-language-server # For nvim-lspconfig
    yaml-language-server # For nvim-lspconfig
  ];

  services.ssh-agent.enable = true;

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    initExtra = builtins.readFile ./zshrc;
    shellAliases = {
      ll = "ls -lah";
    };
    oh-my-zsh = {
      enable = true;
    };
  };

  services.copyq.enable = true;

  programs.autojump = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.thefuck = {
    enable = true;
    enableZshIntegration = true;
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
    extraConfig = builtins.readFile ./vimrc;
    extraLuaConfig = builtins.readFile ./init.lua;
    plugins = with pkgs.vimPlugins; [
      copilot-vim
      vim-fugitive
      # nvim-tree
      {
        plugin = nvim-tree-lua;
        config = ''
          lua <<EOF
            require'nvim-tree'.setup {}
          EOF

          nnoremap <C-n> :NvimTreeToggle<CR>
          autocmd BufEnter * if winnr('$') == 1 && exists('b:term_type') && b:term_type == 'tree' | quit | endif
        '';
      }
      # Telescope
      plenary-nvim
      {
        plugin = telescope-nvim;
        config = ''
          lua << EOF
            require('telescope').setup {
              pickers = {
                find_files = {
                  find_command = { 'rg', '--files', '--hidden', '-g', '!.git/*' }
                }
              }
            }
          EOF

          nnoremap <C-f> :Telescope find_files<CR>
          nnoremap <C-g> :Telescope live_grep<CR>
        '';
      }
      # LSP
      {
        plugin = nvim-lspconfig;
        config = ''
          lua <<EOF
          require'lspconfig'.dartls.setup{}
          require'lspconfig'.terraformls.setup{}
          require'lspconfig'.tsserver.setup{}
          require'lspconfig'.yamlls.setup{}
          EOF
        '';
      }
      nvim-cmp
    ];
  };
}
