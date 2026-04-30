{ config, lib, pkgs, ... }:

let
  commonOpts = [
    "credentials=/etc/nixos/secrets/smb/default.nix"
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
in
{
  options.mymodules.smb-share.enable = lib.mkEnableOption "a-NAS-tasia network share";

  config = lib.mkIf config.mymodules.smb-share.enable {

    environment.systemPackages = [ pkgs.cifs-utils ];
    boot.kernelModules = [ "cifs" ];

    fileSystems."/mnt/appdata" = {
      device = "//192.168.0.143/appdata";
      fsType = "cifs";
      options = commonOpts;
    };

    fileSystems."/mnt/nas" = {
      device = "//192.168.0.143/nas";
      fsType = "cifs";
      options = commonOpts;
    };

    fileSystems."/mnt/docker" = {
      device = "//192.168.0.44/docker";
      fsType = "cifs";
      options = commonOpts;
    };

  };
}
