{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
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
    '';
  };
}
