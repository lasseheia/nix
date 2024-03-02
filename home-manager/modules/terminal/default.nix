{ pkgs, ... }:

{
  imports = [
    ./git.nix
    ./tmux.nix
    ./neovim.nix
  ];

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
