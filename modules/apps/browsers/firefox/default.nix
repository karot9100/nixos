{ config, lib, ... }:

let
  user = config.mymodules.mainUser;
in

{
  options.mymodules.firefox.enable = lib.mkEnableOption "firefox";

  config = lib.mkIf config.mymodules.firefox.enable {

    programs.firefox = {
      enable = true;
      preferences = {
        "privacy.resistFingerprinting"                      = true;
        "ui.systemUsesDarkTheme"                            = "1";
        "layout.css.prefers-color-scheme.content-override"  = "2";
      };
      policies = {
        DisableTelemetry = true;
        Homepage = {
          URL       = "http://misternoons.com";
          Locked    = true;
          StartPage = "homepage";
        };
      };
    };

    systemd.tmpfiles.rules = [
      "v /home/${user}/.mozilla 0755 ${user} users - -"
      "v /home/${user}/.mozilla/firefox 0755 ${user} users - -"
    ];

  };
}
