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

  # fcitx5-skk: use StickyShift rule for semicolon conversion start
  xdg.configFile."fcitx5/conf/skk.conf" = {
    force = true;
    text = ''
      Rule=StickyShift
    '';
  };

  # libskk StickyShift rule: map semicolon to start SKK conversion
  xdg.configFile."libskk/rules/StickyShift/metadata.json" = {
    text = builtins.toJSON {
      name = "StickyShift";
      description = "Use semicolon as sticky shift";
    };
  };

  xdg.configFile."libskk/rules/StickyShift/keymap/hiragana.json" = {
    text = builtins.toJSON {
      include = [ "default/hiragana" ];
      define = {
        keymap = {
          ";" = "start-preedit-no-delete";
        };
      };
    };
  };

  xdg.configFile."libskk/rules/StickyShift/keymap/katakana.json" = {
    text = builtins.toJSON {
      include = [ "default/katakana" ];
      define = {
        keymap = {
          ";" = "start-preedit-no-delete";
        };
      };
    };
  };
}
