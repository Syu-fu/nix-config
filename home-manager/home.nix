{ config, pkgs, ... }:

{
  home.username = "syu-fu";
  home.homeDirectory = "/Users/syu-fu";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  imports = [
    ./git.nix
  ];
}
