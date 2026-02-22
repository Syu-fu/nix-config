{
  home = {
    username = "syu-fu";
    homeDirectory = "/Users/syu-fu";
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;

  imports = [
    ./bat.nix
    ./fzf.nix
    ./gh.nix
    ./git.nix
    ./lazygit.nix
    ./ripgrep.nix
    ./tmux.nix
    ./wezterm.nix
  ];
}
