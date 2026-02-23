{ pkgs, ... }:
let
  vimium = pkgs.fetchFirefoxAddon {
    name = "vimium";
    url = "https://addons.mozilla.org/firefox/downloads/file/4618554/vimium_ff-2.3.1.xpi";
    hash = "sha256-0wqlb4iik74h1jilkif20zl6br3l3rfvjq2fdsic4f8rnhf8c6rc=";
  };
  toggl = pkgs.fetchFirefoxAddon {
    name = "toggl";
    url = "https://addons.mozilla.org/firefox/downloads/file/4666536/toggl_button_time_tracker-4.11.8.xpi";
    hash = "sha256-11pw6q3fqv4yf8ma59izn0qfmhyhbhh1fcpbgvijfpn7p2k336nd=";
  };
in
{
  programs.firefox = {
    enable = true;
    profiles.default = {
      extensions.packages = [ vimium toggl ];
    };
  };

  home.packages = pkgs.lib.optionals (!pkgs.stdenv.isDarwin) [
    pkgs.chromium
  ];
}
