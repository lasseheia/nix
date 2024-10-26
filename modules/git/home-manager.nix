{
  pkgs,
  ...
}:

{
  services.ssh-agent.enable = if pkgs.stdenv.isDarwin then false else true;

  programs = {
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
  };
}
