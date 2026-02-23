{ pkgs, ... }:
{
  programs.firefox.enable = true;

  home.packages = pkgs.lib.optionals (!pkgs.stdenv.isDarwin) [
    pkgs.chromium
  ];
}
