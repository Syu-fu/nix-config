{ pkgs, ... }:
let
  # On macOS, M- is triggered by Cmd key via WezTerm key remapping.
  # On NixOS, M- is triggered by Alt key.
  mod = if pkgs.stdenv.isDarwin then "M" else "M";
in
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
      bind -n ${mod}-H select-pane -L
      bind -n ${mod}-J select-pane -D
      bind -n ${mod}-K select-pane -U
      bind -n ${mod}-L select-pane -R
      bind -n ${mod}-h previous-window
      bind -n ${mod}-l next-window
      bind -n ${mod}-k new-window -c "#{pane_current_path}"
      bind -n ${mod}-j confirm-before 'kill-window'
      bind-key -n ${mod}-1 select-window -t :=1
      bind-key -n ${mod}-2 select-window -t :=2
      bind-key -n ${mod}-3 select-window -t :=3
      bind-key -n ${mod}-4 select-window -t :=4
      bind-key -n ${mod}-5 select-window -t :=5
      bind-key -n ${mod}-6 select-window -t :=6
      bind-key -n ${mod}-7 select-window -t :=7
      bind-key -n ${mod}-8 select-window -t :=8
      bind-key -n ${mod}-9 select-window -t :=9
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5
      bind -n C-] new-window "~/.config/tmux/scripts/ghq-tmux-switch.sh"
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
  };

  xdg.configFile."tmux/scripts/ghq-tmux-switch.sh" = {
    executable = true;
    text = ''
      #!/bin/bash

      # Set color variables
      green=$(tput setaf 2)
      blue=$(tput setaf 4)
      reset=$(tput sgr0)

      # Set checkmark variables
      checked="󰄲"
      unchecked="󰄱"

      window_exists() {
        tmux list-windows -t "$1" >/dev/null 2>&1
      }

      # Generate window list
      generate_window_list() {
        ghq list | sort | while read -r repo; do
          window="''${repo//[:. ]/-}"
          color="$blue"
          icon="$unchecked"
          if window_exists "$window"; then
            color="$green"
            icon="$checked"
          fi
          printf "$color$icon %s$reset\n" "$repo"
        done
      }

      # Define preview command
      preview_cmd="echo {} | cut -d' ' -f2- | xargs -I% sh -c 'bat --color=always --style=plain \$(find \"\$(ghq root)/%\" -maxdepth 1 | grep -i -E \"README(\\..*)?\")'"

      # Select window
      selected="$(generate_window_list | fzf-tmux -p 80% --ansi --exit-0 --preview="$preview_cmd" --preview-window="right:60%" | cut -d' ' -f2-)"

      # If not inside a tmux session, attach or create
      session_name="''${selected//[:. ]/-}"
      repo_dir="$(ghq list --exact --full-path "$selected")"

      if [ -z "$TMUX" ]; then
        if tmux has-session -t "$session_name" 2>/dev/null; then
          BUFFER="tmux attach-session -t ''${session_name}"
        else
          tmux new-session -d -s "''${session_name}" -c "''${repo_dir}"
          BUFFER="tmux attach-session -t ''${session_name}"
        fi
      else
        if [ "$(tmux display-message -p "#S")" != "$session_name" ]; then
          if tmux has-session -t "$session_name" 2>/dev/null; then
            tmux switch-client -t "$session_name"
          else
            tmux new-session -d -s "''${session_name}" -c "''${repo_dir}"
            tmux switch-client -t "$session_name"
          fi
        elif [ "$PWD" != "$repo_dir" ]; then
          BUFFER="cd ''${repo_dir}"
        fi
      fi

      eval "$BUFFER"
    '';
  };

  programs.tmux.plugins = with pkgs.tmuxPlugins; [
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
}
