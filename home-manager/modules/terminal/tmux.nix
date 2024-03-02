{ pkgs, ... }:

{
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
}
