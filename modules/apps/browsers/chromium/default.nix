{ config, pkgs, lib, ... }:

let
  user = config.mymodules.mainUser;
in

{
  options.mymodules.chromium.enable = lib.mkEnableOption "chromium";

  config = lib.mkIf config.mymodules.chromium.enable {

    environment.systemPackages = with pkgs; [ chromium ];

    systemd.tmpfiles.rules = [
      "d /home/${user}/.config/chromium 0755 ${user} users - -"
    ];

  };

}
