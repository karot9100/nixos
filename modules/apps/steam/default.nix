{ config, pkgs, lib, ... }:

{

  options.mymodules.steam.enable = lib.mkEnableOption "steam";

  config = lib.mkIf config.mymodules.steam.enable {

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = false;
      dedicatedServer.openFirewall = false;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };

    environment.systemPackages = with pkgs; [
      protonup-qt
    ];

  };
  
}

