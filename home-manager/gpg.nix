{ pkgs, ... }:
{
  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-qt;
    enableSshSupport = true;
  };

  programs.gpg = {
    enable = true;
  };
}
