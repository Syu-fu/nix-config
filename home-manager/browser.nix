{ pkgs, ... }:
let
  vimium = pkgs.fetchFirefoxAddon {
    name = "vimium";
    url = "https://addons.mozilla.org/firefox/downloads/file/4618554/vimium_ff-2.3.1.xpi";
    hash = "sha256-LBuGHLQZOcKibk5guV0edORl6AfCxUmjDJCcGSNZFHM=";
  };
  toggl = pkgs.fetchFirefoxAddon {
    name = "toggl";
    url = "https://addons.mozilla.org/firefox/downloads/file/4666536/toggl_button_time_tracker-4.11.8.xpi";
    hash = "sha256-zZoxprjHXifjfusyFyBc0MPqMLA/pqIqcp5s7AY2/IY=";
  };
  onepassword = pkgs.fetchFirefoxAddon {
    name = "1password";
    url = "https://addons.mozilla.org/firefox/downloads/file/4692796/1password_x_password_manager-8.12.2.38.xpi";
    hash = "sha256-JS0RDHqiOr30yIiZCuSD5Qj2/dzfJf3/Yo+Hr04bBN4=";
  };
  deepl = pkgs.fetchFirefoxAddon {
    name = "deepl";
    url = "https://addons.mozilla.org/firefox/downloads/file/4682211/deepl_translate-1.72.0.xpi";
    hash = "sha256-vxKSdOoneu/mEBU9YRnmEKIGBu1oPD7Q1j6Uvq0nHVI=";
  };
  obsidianWebClipper = pkgs.fetchFirefoxAddon {
    name = "obsidian-web-clipper";
    url = "https://addons.mozilla.org/firefox/downloads/file/4585733/web_clipper_obsidian-0.12.0.xpi";
    hash = "sha256-nbDIyWCaS4SJ0uF54McJob1MkbDELfvn9fXRAqHqtbc=";
  };
in
{
  programs.firefox = {
    enable = true;
    profiles.default = {
      extensions.packages = [ vimium toggl onepassword deepl obsidianWebClipper ];
    };
  };

  home.packages = pkgs.lib.optionals (!pkgs.stdenv.isDarwin) [
    pkgs.chromium
  ];
}
