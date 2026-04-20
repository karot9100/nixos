{ config, pkgs, lib, ... }:

{

  options.mymodules.gamemode.enable = lib.mkEnableOption "gamemode";

  config = lib.mkIf config.mymodules.gamemode.enable {

    programs.gamemode.enable = true;
    
    environment.systemPackages = with pkgs; [
      gamemode
      gamescope
      mangohud
    ];

  };

}
