{ config, pkgs, lib, ... }:

let
  user = config.mymodules.mainUser;
in
{
  options.mymodules.screenshot.enable = lib.mkEnableOption "screenshot";

  config = lib.mkIf config.mymodules.screenshot.enable {

    environment.systemPackages = with pkgs; [ grim slurp ];

    systemd.user.tmpfiles.rules = [
      "d /home/${user}/Screenshots 0755 ${user} users -"
    ];

  };
}
