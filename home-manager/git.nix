{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Syu-fu";
    userEmail = "syu-fu@gmail.com";
    
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
      core.editor = "nvim";
    };
  };
}
