_:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      background = [
        {
          monitor = "";
          color = "rgba(1d2021ff)";
          blur_passes = 2;
          blur_size = 4;
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "300, 50";
          outline_thickness = 2;
          outer_color = "rgba(a9b665ff)";
          inner_color = "rgba(282828ff)";
          font_color = "rgba(d4be98ff)";
          placeholder_text = "Password...";
          rounding = 8;
        }
      ];

      label = [
        {
          monitor = "";
          text = "$TIME";
          color = "rgba(d4be98ff)";
          font_size = 64;
          font_family = "HackGenConsole NF";
          position = "0, 160";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:60000] date +'%Y年%m月%d日 (%a)'";
          color = "rgba(a89984ff)";
          font_size = 20;
          font_family = "HackGenConsole NF";
          position = "0, 80";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
