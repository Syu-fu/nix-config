{ pkgs, ... }:
{
  home = {
    username = "syu-fu";
    homeDirectory = if pkgs.stdenv.isDarwin then "/Users/syu-fu" else "/home/syu-fu";
    stateVersion = "24.05";

    packages = with pkgs; [
      trashy
    ] ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
      gnugrep
      gnused
    ];
  };

  programs.home-manager.enable = true;

  imports = [
    ./bat.nix
    ./browser.nix
    ./fzf.nix
    ./gh.nix
    ./git.nix
    ./hyprland.nix
    ./lazygit.nix
    ./lsd.nix
    ./ripgrep.nix
    ./rofi.nix
    ./tmux.nix
    ./wezterm.nix
    ./zsh.nix
  ];
}
