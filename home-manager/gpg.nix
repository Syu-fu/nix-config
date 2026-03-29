{ pkgs, ... }:
{
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
    enableSshSupport = true;
  };

  programs.gpg = {
    enable = true;
  };
}
