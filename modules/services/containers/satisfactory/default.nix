{ config, lib, ... }:

{
  options.mymodules.containers.satisfactory.enable =
    lib.mkEnableOption "Satisfactory dedicated server container";

  config = lib.mkIf config.mymodules.containers.satisfactory.enable {

    # Ensure Docker is enabled when this container is enabled
    mymodules.docker.enable = true;

    # Make sure the bind-mount path exists with correct ownership
    systemd.tmpfiles.rules = [
      "d /docker/satisfactory-server 0755 1000 100 - -"
    ];

    virtualisation.oci-containers.containers.satisfactory-server = {
      image = "wolveix/satisfactory-server:latest";
      hostname = "satisfactory-server";

      ports = [
        "7777:7777/tcp"
        "7777:7777/udp"
        "8888:8888/tcp"
      ];

      volumes = [
        "/docker/satisfactory-server:/config"
      ];

      environment = {
        MAXPLAYERS = "4";
        PGID = "1000";
        PUID = "1000";
        STEAMBETA = "false";
      };

      # Memory limits (the compose `deploy.resources` equivalent)
      extraOptions = [
        "--memory=8g"
        "--memory-reservation=4g"
      ];
    };

    # Open the firewall for the game ports
    networking.firewall = {
      allowedTCPPorts = [ 7777 8888 ];
      allowedUDPPorts = [ 7777 ];
    };
  };
}
