{ config, pkgs, lib, ... }:

{

  options.mymodules.docker.enable = lib.mkEnableOption "docker";

  config = lib.mkIf config.mymodules.docker.enable {

    virtualisation.docker.enable = true;
    virtualisation.oci-containers.backend = "docker";

  };

}

