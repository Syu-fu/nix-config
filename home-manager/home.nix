{
  home = {
    username = "syu-fu";
    homeDirectory = "/Users/syu-fu";
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;

  imports = [
    ./git.nix
    ./lazygit.nix
    ./wezterm.nix
  ];
}
