{ config, pkgs, lib, ... }:

{

  options.mymodules.thunar.enable = lib.mkEnableOption "thunar";

  config = lib.mkIf config.mymodules.thunar.enable {

    environment.systemPackages = with pkgs; [
      gvfs
      cifs-utils
      xfce.exo
    ];

    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-media-tags-plugin
        thunar-volman
      ];
    };

    services.gvfs.enable = true;
    services.dbus.enable = true;

  };

}

