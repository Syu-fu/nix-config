{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    profiles.default = { };
    policies = {
      ExtensionSettings = {
        "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4618554/vimium_ff-2.3.1.xpi";
          installation_mode = "force_installed";
        };
        "toggl-button@toggl.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4666536/toggl_button_time_tracker-4.11.8.xpi";
          installation_mode = "force_installed";
        };
        "{d634138d-c276-4fc8-924b-40a0ea21d284}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4692796/1password_x_password_manager-8.12.2.38.xpi";
          installation_mode = "force_installed";
        };
        "firefox-extension@deepl.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4682211/deepl_translate-1.72.0.xpi";
          installation_mode = "force_installed";
        };
        "clipper@obsidian.md" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4585733/web_clipper_obsidian-0.12.0.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
    };
  };

  home.packages = pkgs.lib.optionals (!pkgs.stdenv.isDarwin) [
    pkgs.chromium
  ];
}
