{ config, pkgs, lib, ... }:

let
  user = config.mymodules.mainUser;
in
{
  options.mymodules.gdm.enable = lib.mkEnableOption "GDM";

  config = lib.mkIf config.mymodules.gdm.enable {

    services.displayManager.gdm = {
      enable  = true;
      wayland = true;
    };
    services.displayManager.autoLogin = {
      enable = true;
      user   = user;
    };

    systemd.services."getty@tty1".enable   = false;
    systemd.services."autovt@tty1".enable  = false;

  };

}
