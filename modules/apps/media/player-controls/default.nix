{ config, pkgs, lib, ... }:

{

  options.mymodules.playercontrols.enable = lib.mkEnableOption "Player Controls";

  config = lib.mkIf config.mymodules.playercontrols.enable {

    environment.systemPackages = with pkgs; [
      playerctl
    ];

  };

}
