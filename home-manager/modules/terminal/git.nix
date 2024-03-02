{
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
}
