{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    prefix = "C-s";
    terminal = "tmux-256color";
    baseIndex = 1;
    historyLimit = 5000;
    extraConfig = ''
      set-option -g default-shell $SHELL
      set-option -g default-command $SHELL
      set-option -g renumber-windows on
      set-option -g status on
      set-option -g status-interval 2
      set-option -g display-time 1000
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
