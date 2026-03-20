_:
{
  # fcitx5 profile: SKK only (no input method switching)
  xdg.configFile."fcitx5/profile" = {
    force = true;
    text = ''
      [Groups/0]
      Name=Default
      Default Layout=us
      DefaultIM=skk

      [Groups/0/Items/0]
      Name=skk
      Layout=

      [GroupOrder]
      0=Default
    '';
  };

  # fcitx5-skk: use semicolon as sticky key (one-shot shift = SKK conversion start)
  xdg.configFile."fcitx5/conf/skk.conf" = {
    force = true;
    text = ''
      [Behavior]
      StickyKey=semicolon
    '';
  };
}
