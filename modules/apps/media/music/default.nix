{ config, pkgs, lib, ... }:

{

  options.mymodules.music.enable = lib.mkEnableOption "music";

  config = lib.mkIf config.mymodules.music.enable {

    environment.systemPackages = with pkgs; [
      rmpc
      supersonic
    ];

  };

}
