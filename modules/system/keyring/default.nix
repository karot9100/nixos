{ config, pkgs, lib, ... }:

{

  options.mymodules.keyring.enable = lib.mkEnableOption "keyring";

  config = lib.mkIf config.mymodules.keyring.enable {

    services.gnome.gnome-keyring.enable = true;
    security.pam.services.login.enableGnomeKeyring = true;

  };

}
