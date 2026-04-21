{ config, lib, pkgs, ... }:

{

  options.myusers.serveruser.enable = lib.mkEnableOption "Optiplex Serveruser";
  config = lib.mkIf config.myusers.serveruser.enable {

    users.users.serveruser = {
      isNormalUser = true;
      description  = "Optiplex Serveruser";
      extraGroups  = [
        "wheel"
        "video"
        "render"
        "docker"
        "libvirt"
      ];
    };

    users.groups.video  = {};
    users.groups.render = {};

    security.sudo.wheelNeedsPassword = true;

  };

}
