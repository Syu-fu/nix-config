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
  onepassword = pkgs.fetchFirefoxAddon {
    name = "1password";
    url = "https://addons.mozilla.org/firefox/downloads/file/4692796/1password_x_password_manager-8.12.2.38.xpi";
    hash = "sha256-1ph43d7az1wgcbzzs9fzvkyzc275hgj0m6c8r3sbsfm2g8612b95=";
  };
in
{
  programs.firefox = {
    enable = true;
    profiles.default = {
      extensions.packages = [ vimium toggl onepassword ];
    };
  };

  home.packages = pkgs.lib.optionals (!pkgs.stdenv.isDarwin) [
    pkgs.chromium
  ];
}
