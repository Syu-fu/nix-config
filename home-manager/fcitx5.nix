{ pkgs, ... }:
let
  skkTimeServerConversions = import ../skk-time-server-conversions.nix;
  # Generate sed expression to delete dynamic entries from user.dict
  cleanupSedExpr = builtins.concatStringsSep "" (
    map (key: "/^${key} /d;") (builtins.attrNames skkTimeServerConversions)
  );
in
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

  # fcitx5-skk dictionary list: user dict + skkserv + system dict
  xdg.dataFile."fcitx5/skk/dictionary_list".text = ''
    type=file,file=$FCITX_CONFIG_DIR/skk/user.dict,mode=readwrite
    type=server,host=127.0.0.1,port=1178,encoding=EUC-JP
    type=file,file=${pkgs.skkDictionaries.l}/share/skk/SKK-JISYO.L,mode=readonly
  '';

  # Periodically remove dynamic entries (skk-time-server) from user.dict
  systemd.user.services.skk-user-dict-cleanup = {
    Unit.Description = "Remove skk-time-server entries from SKK user dictionary";
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.gnused}/bin/sed -i '${cleanupSedExpr}' %h/.local/share/fcitx5/skk/user.dict";
    };
  };

  systemd.user.timers.skk-user-dict-cleanup = {
    Unit.Description = "Periodically clean SKK user dictionary";
    Timer = {
      OnCalendar = "*:0/5";
      Persistent = true;
    };
    Install.WantedBy = [ "timers.target" ];
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
