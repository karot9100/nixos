{ config, lib, pkgs, ... }:

{
  options.mymodules.smb-share.enable = lib.mkEnableOption "a-NAS-tasia network share";

  config = lib.mkIf config.mymodules.smb-share.enable {

    environment.systemPackages = [ pkgs.cifs-utils ];

    fileSystems."/appdata" = {
      device = "//192.168.0.144/appdata";
      fsType = "cifs";
      options = [
        "credentials=/etc/nixos/secrets/smb"
        "uid=1000"
        "gid=100"
        "iocharset=utf8"
        "vers=3.0"
        "noauto"
        "x-systemd.automount"
        "x-systemd.idle-timeout=60"
        "x-systemd.mount-timeout=10s"
        "_netdev"
      ];
    };
    
    fileSystems."/nas" = {
      device = "//192.168.0.144/nas";
      fsType = "cifs";
      options = [
        "credentials=/etc/nixos/secrets/smb"
        "uid=1000"
        "gid=100"
        "iocharset=utf8"
        "vers=3.0"
        "noauto"
        "x-systemd.automount"
        "x-systemd.idle-timeout=60"
        "x-systemd.mount-timeout=10s"
        "_netdev"
      ];

  };
}
