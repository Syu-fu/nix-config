{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    prefix = "C-s";
    terminal = "tmux-256color";
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
