{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    prefix = "C-s";
    terminal = "tmux-256color";
    baseIndex = 1;
    historyLimit = 5000;
    keyMode = "vi";
    escapeTime = 20;
    mouse = true;
    aggressiveResize = true;
    extraConfig = ''
      set-option -g default-shell $SHELL
      set-option -g default-command ""
      set-option -g set-clipboard on
      set-option -g bell-action other
      set-option -g visual-bell off
      set-option -g status-keys emacs
      set-option -g set-titles on
      set-option -g set-titles-string '#T'
      set-window-option -g automatic-rename on
      set-option -g word-separators " -_()@,[]{}:=/"
      bind d detach
      bind A command-prompt "rename-window %%"
      bind R command-prompt "rename-session %%"
      bind C-w choose-window
      bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"
      bind '\' split-window -hc "#{pane_current_path}"
      bind -n 'M-\' split-window -hc "#{pane_current_path}"
      bind - split-window -vc "#{pane_current_path}"
      bind -n M-- split-window -vc "#{pane_current_path}"
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      set-option -g renumber-windows on
      set-option -g status on
      set-option -g status-interval 2
      set-option -g display-time 1000
      set-option -ga terminal-overrides ",xterm*:Tc"
      set-option -ga terminal-overrides ",xterm*:smcup@:rmcup@"
      set-option -ga terminal-overrides ',rxvt-uni*:XT:Ms=\E]52;%p1%s;%p2%s\007'
      set-option -ga terminal-overrides ',*:U8=0'
      set-option -ga terminal-overrides ',*:Ss=\E[%p1%d q:Se=\E[2 q'
      set -sa terminal-overrides ',xterm-256color:RGB'
      set -sa terminal-overrides ',*:Smulx=\E[4::%p1%dm'
    '';
    plugins = with pkgs.tmuxPlugins; [
      tmux-fzf
      resurrect
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-boot 'on'
          set -g @continuum-restore 'on'
        '';
      }
      {
        plugin = gruvbox;
        extraConfig = ''
          set -g @tmux-gruvbox 'dark'
        '';
      }
    ];
  };
}
