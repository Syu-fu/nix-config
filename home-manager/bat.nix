{
  programs.bat = {
    enable = true;
    config = {
      theme = "gruvbox-material-dark";
    };
  };

  xdg.configFile."bat/themes/gruvbox-material-dark.tmTheme".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>name</key>
      <string>gruvbox-material-dark</string>
      <key>settings</key>
      <array>
        <dict>
          <key>settings</key>
          <dict>
            <key>background</key>
            <string>#1d2021</string>
            <key>foreground</key>
            <string>#d4be98</string>
            <key>caret</key>
            <string>#d4be98</string>
            <key>selection</key>
            <string>#45403d</string>
            <key>selectionForeground</key>
            <string>#d4be98</string>
            <key>lineHighlight</key>
            <string>#282828</string>
          </dict>
        </dict>
        <dict>
          <key>name</key>
          <string>Comment</string>
          <key>scope</key>
          <string>comment, punctuation.definition.comment</string>
          <key>settings</key>
          <dict>
            <key>foreground</key>
            <string>#7c6f64</string>
            <key>fontStyle</key>
            <string>italic</string>
          </dict>
        </dict>
        <dict>
          <key>name</key>
          <string>String</string>
          <key>scope</key>
          <string>string, string.quoted</string>
          <key>settings</key>
          <dict>
            <key>foreground</key>
            <string>#a9b665</string>
          </dict>
        </dict>
        <dict>
          <key>name</key>
          <string>Number</string>
          <key>scope</key>
          <string>constant.numeric</string>
          <key>settings</key>
          <dict>
            <key>foreground</key>
            <string>#d8a657</string>
          </dict>
        </dict>
        <dict>
          <key>name</key>
          <string>Built-in constant</string>
          <key>scope</key>
          <string>constant.language, constant.other</string>
          <key>settings</key>
          <dict>
            <key>foreground</key>
            <string>#d8a657</string>
          </dict>
        </dict>
        <dict>
          <key>name</key>
          <string>Keyword</string>
          <key>scope</key>
          <string>keyword, keyword.control, keyword.operator, storage.type, storage.modifier</string>
          <key>settings</key>
          <dict>
            <key>foreground</key>
            <string>#ea6962</string>
          </dict>
        </dict>
        <dict>
          <key>name</key>
          <string>Function name</string>
          <key>scope</key>
          <string>entity.name.function, meta.function-call</string>
          <key>settings</key>
          <dict>
            <key>foreground</key>
            <string>#7daea3</string>
          </dict>
        </dict>
        <dict>
          <key>name</key>
          <string>Type</string>
          <key>scope</key>
          <string>entity.name.type, entity.name.class, support.type, support.class</string>
          <key>settings</key>
          <dict>
            <key>foreground</key>
            <string>#89b482</string>
          </dict>
        </dict>
        <dict>
          <key>name</key>
          <string>Tag</string>
          <key>scope</key>
          <string>entity.name.tag, meta.tag</string>
          <key>settings</key>
          <dict>
            <key>foreground</key>
            <string>#ea6962</string>
          </dict>
        </dict>
        <dict>
          <key>name</key>
          <string>Attribute</string>
          <key>scope</key>
          <string>entity.other.attribute-name</string>
          <key>settings</key>
          <dict>
            <key>foreground</key>
            <string>#e78a4e</string>
          </dict>
        </dict>
        <dict>
          <key>name</key>
          <string>Variable</string>
          <key>scope</key>
          <string>variable, variable.other</string>
          <key>settings</key>
          <dict>
            <key>foreground</key>
            <string>#d4be98</string>
          </dict>
        </dict>
        <dict>
          <key>name</key>
          <string>Punctuation</string>
          <key>scope</key>
          <string>punctuation</string>
          <key>settings</key>
          <dict>
            <key>foreground</key>
            <string>#a89984</string>
          </dict>
        </dict>
        <dict>
          <key>name</key>
          <string>Operator</string>
          <key>scope</key>
          <string>keyword.operator</string>
          <key>settings</key>
          <dict>
            <key>foreground</key>
            <string>#89b482</string>
          </dict>
        </dict>
        <dict>
          <key>name</key>
          <string>Import / Include</string>
          <key>scope</key>
          <string>keyword.control.import, keyword.control.include</string>
          <key>settings</key>
          <dict>
            <key>foreground</key>
            <string>#d3869b</string>
          </dict>
        </dict>
      </array>
    </dict>
    </plist>
  '';
}
