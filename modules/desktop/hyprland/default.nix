{ config, pkgs, lib, ... }:

let
  user = config.mymodules.mainUser;
in

{
  options.mymodules.hyprland.enable = lib.mkEnableOption "hyprland";

  config = lib.mkIf config.mymodules.hyprland.enable {
   
    # Import gdm module
    mymodules.gdm.enable = true;

    programs.hyprland = {
      enable          = true;
      withUWSM        = true;
      xwayland.enable = true;
    };

    systemd.services.swayosd-libinput-backend = {
      description = "SwayOSD LibInput backend for listening to certain keys";
      wantedBy    = [ "multi-user.target" ];
      serviceConfig = {
        Type      = "simple";
        ExecStart = "${pkgs.swayosd}/bin/swayosd-libinput-backend";
        Restart   = "always";
      };
    };

    xdg.portal = {
      enable       = true;
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    };

    environment.systemPackages = with pkgs; [
      hyprpaper
      hyprlock
      hypridle
      hyprpolkitagent
      waybar
      swayosd
      fuzzel
    ];

  };

}
