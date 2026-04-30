{ config, lib, pkgs, ... }:

{
  options.mymodules.smb-server.enable =
    lib.mkEnableOption "Samba file server";

  config = lib.mkIf config.mymodules.smb-server.enable {

    services.samba = {
      enable = true;
      openFirewall = true;

      settings = {
        global = {
          "workgroup" = "WORKGROUP";
          "server string" = "optiplex";
          "security" = "user";
          "map to guest" = "never";
        };

        docker = {
          "path" = "/docker";
          "browseable" = "yes";
          "read only" = "no";
          "guest ok" = "no";
          "valid users" = "simon";
          "create mask" = "0644";
          "directory mask" = "0755";
          "force user" = "simon";
          "force group" = "users";
        };
      };
    };
  };
}
