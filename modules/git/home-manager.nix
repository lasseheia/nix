{
  programs = {
    git = {
      enable = true;
      settings = {
        user = {
          name = "Lasse Heia";
          email = "23742718+lasseheia@users.noreply.github.com";
        };
        pull.rebase = true;
        rebase.autoStash = true;
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
        push.autoSetupRemote = true;
        core.ignorecase = false;
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
    git.settings.credential = {
      "https://github.com" = {
        helper = "!gh auth git-credential";
      };
      "https://gist.github.com" = {
        helper = "!gh auth git-credential";
      };
    };
  };
}
