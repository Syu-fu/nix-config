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
      (mkDeferredPlugin "fzf-tab" pkgs.zsh-fzf-tab "share/fzf-tab/fzf-tab.plugin.zsh")
      (mkDeferredPlugin "fast-syntax-highlighting" pkgs.zsh-fast-syntax-highlighting "share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh")
      (mkDeferredPlugin "zsh-abbr" pkgs.zsh-abbr "share/zsh/zsh-abbr/zsh-abbr.zsh")
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
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

      # Load p10k theme config
      [[ -f ~/.config/zsh/p10k.zsh ]] && source ~/.config/zsh/p10k.zsh

      # Auto-start tmux
      if [ -z "$TMUX" ]; then
        tmux new-session -A -s main
      fi
    '';
  };

  xdg.configFile."zsh/p10k.zsh".source = ./p10k.zsh;

  xdg.dataFile."zsh/abbreviations".text = ''
    abbr nv=nvim
    abbr e=nvim
    abbr rm=trash
    abbr lg=lazygit
    abbr copypath='pwd | tr -d "\n" | pbcopy'
    abbr -g "npm i"="npm install"
    abbr -g "pnpm i"="pnpm install"
    abbr -g "npm install -D"="npm install --save-dev"
    abbr -g "pnpm install -D"="pnpm install --save-dev"
  '';
}
