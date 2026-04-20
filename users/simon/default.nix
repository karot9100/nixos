{ config, lib, pkgs, ... }:

{

  options.myusers.simon.enable = lib.mkEnableOption "Simon Vuylsteke";
  config = lib.mkIf config.myusers.simon.enable {

    users.users.simon = {
      isNormalUser = true;
      description  = "Simon Vuylsteke";
      extraGroups  = [
        "wheel"
        "networkmanager"
        "video"
        "render"
        "lpadmin"
        "docker"
        "libvirt"
      ];
    };

    users.groups.video  = {};
    users.groups.render = {};

    security.sudo.wheelNeedsPassword = true;

  };

}
