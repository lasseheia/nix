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
    nodejs # Required for nvim-copilot
    yarn
    ripgrep # For nvim-telescope
    sweethome3d.application
    flutter
    terraform-ls # For nvim-lspconfig
    typescript # For nvim-lspconfig
    nodePackages.typescript
    nodePackages.typescript-language-server # For nvim-lspconfig
    age
    hugo
    rustc
    cargo
    kubeseal
    fluxcd
    ipcalc
    yaml-language-server # For nvim-lspconfig
  ];

  services.ssh-agent.enable = true;

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    initExtra = ''
      [[ -z "$TMUX" ]] && tmux
      bindkey '^ ' autosuggest-accept
      bindkey '^[^M' autosuggest-execute
      bindkey "^k" history-beginning-search-backward
      bindkey "^j" history-beginning-search-forward
      if [ ! -S ~/.ssh/ssh_auth_sock ]; then
        eval `ssh-agent`
        ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
      fi
      export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
      ssh-add -l > /dev/null || ssh-add
    '';
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
      bind -n M-h select-pane -L
      bind -n M-l select-pane -R
      bind -n M-j select-pane -U
      bind -n M-k select-pane -D

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
    vimdiffAlias = true;
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
      set clipboard+=unnamedplus
      highlight Normal ctermbg=none
      highlight NonText ctermbg=none
    '';
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
}
