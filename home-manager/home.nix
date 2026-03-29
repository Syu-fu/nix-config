{ pkgs, ... }:
{
  home = {
    username = "syu-fu";
    homeDirectory = if pkgs.stdenv.isDarwin then "/Users/syu-fu" else "/home/syu-fu";
    stateVersion = "24.05";

    packages = with pkgs; [
      ghq
      trashy
      hackgen-nf-font
      difftastic
    ] ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
      gnugrep
      gnused
    ] ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
      obsidian
    ];
  };

  programs.home-manager.enable = true;

  imports = [
    ./bat.nix
    ./browser.nix
    ./fcitx5.nix
    ./fzf.nix
    ./gh.nix
    ./git.nix
    ./gpg.nix
    ./gtk.nix
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./hyprpanel.nix
    ./lazygit.nix
    ./lsd.nix
    ./ripgrep.nix
    ./rofi.nix
    ./tmux.nix
    ./vim.nix
    ./wezterm.nix
    ./zsh.nix
  ];
}
