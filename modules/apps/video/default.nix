{ config, pkgs, lib, ... }:

{

  options.mymodules.video.enable = lib.mkEnableOption "video";

  config = lib.mkIf config.mymodules.video.enable {

    environment.systemPackages = with pkgs; [
      vlc
    ];

  };

}
