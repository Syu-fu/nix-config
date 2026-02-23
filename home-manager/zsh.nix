{ pkgs, ... }:
let
  mkDeferredPlugin = name: pkg: file: {
    inherit name;
    src = pkgs.runCommand "deferred-${name}" { } ''
      mkdir -p $out
      echo "zsh-defer source ${pkg}/${file}" > $out/${name}.plugin.zsh
    '';
    file = "${name}.plugin.zsh";
  };
in
{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    defaultKeymap = "emacs";
    enableCompletion = true;
    initExtraBeforeCompInit = ''
      fpath+=(${pkgs.zsh-completions}/share/zsh/site-functions)
    '';
    plugins = [
      {
        name = "zsh-defer";
        src = pkgs.zsh-defer;
        file = "share/zsh-defer/zsh-defer.plugin.zsh";
      }
      (mkDeferredPlugin "zsh-autosuggestions" pkgs.zsh-autosuggestions "share/zsh-autosuggestions/zsh-autosuggestions.zsh")
      (mkDeferredPlugin "fast-syntax-highlighting" pkgs.zsh-fast-syntax-highlighting "share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh")
      (mkDeferredPlugin "zsh-abbr" pkgs.zsh-abbr "share/zsh/zsh-abbr/zsh-abbr.zsh")
    ];
    sessionVariables = {
      LANG = "ja_JP.UTF-8";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";
      XDG_CACHE_HOME = "$HOME/.cache";
      EDITOR = "nvim";
      VISUAL = "nvim";
      PAGER = "less";
      GHQ_ROOT = "$HOME/repos";
    };
    history = {
      ignoreAllDups = true;
      share = true;
      size = 1000;
      save = 10000000;
      path = "$HOME/.config/zsh/.zsh_history";
      ignorePatterns = [
        "cd"
        "pwd"
        "l[sal]"
        "nvim"
        "vim"
        "less"
        "which"
        "whois"
        "lazygit"
        "xdg-open"
      ];
    };
    initContent = ''
      setopt HIST_REDUCE_BLANKS
      setopt HIST_NO_STORE

      # Auto-start tmux
      if [ -z "$TMUX" ]; then
        tmux new-session -A -s main
      fi
    '';
  };

  xdg.dataFile."zsh/abbreviations".text = ''
    abbr nv=nvim
    abbr e=nvim
  '';
}
