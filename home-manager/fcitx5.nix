_:
{
  # fcitx5 profile: SKK only (no input method switching)
  xdg.configFile."fcitx5/profile" = {
    force = true;
    text = ''
      [Groups/0]
      Name=Default
      Default Layout=jp
      DefaultIM=skk

      [Groups/0/Items/0]
      Name=skk
      Layout=

      [GroupOrder]
      0=Default
    '';
  };
}
