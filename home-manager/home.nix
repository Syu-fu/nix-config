{ pkgs, ... }:
{
  home = {
    username = "syu-fu";
    homeDirectory = "/Users/syu-fu";
    stateVersion = "24.05";

    packages = with pkgs; [
      trashy
    ];
  };

  programs.home-manager.enable = true;

  imports = [
    ./bat.nix
    ./fzf.nix
    ./gh.nix
    ./git.nix
    ./lazygit.nix
    ./lsd.nix
    ./ripgrep.nix
    ./tmux.nix
    ./wezterm.nix
    ./zsh.nix
  ];
}
