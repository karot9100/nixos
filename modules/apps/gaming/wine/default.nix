{ config, pkgs, lib, ... }:

{

  options.mymodules.wine.enable = lib.mkEnableOption "wine";

  config = lib.mkIf config.mymodules.wine.enable {

    environment.systemPackages = with pkgs; [
      wine
      wineWowPackages.stable
      winetricks
    ];

  };

}

