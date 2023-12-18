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
  ];

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    initExtra = ''
      [[ -z "$TMUX" ]] && tmux
      bindkey '^ ' autosuggest-accept
      bindkey '^[^M' autosuggest-execute
      bindkey "^k" history-beginning-search-backward
      bindkey "^j" history-beginning-search-forward
    '';
    shellAliases = {
      ll = "ls -lah";
    };
    oh-my-zsh = {
      enable = true;
    };
  };

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
    '';
    extraLuaConfig = ''
      vim.g.mapleader = "<Space>"
    '';
    plugins = with pkgs.vimPlugins; [
      ssr
      nvim-tree-lua
      nvim-treesitter
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

  # Workaround for https://github.com/nix-community/home-manager/issues/4744
  programs.gh.settings.version = 1;
}
