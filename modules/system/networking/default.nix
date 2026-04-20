{ config, pkgs, lib, ... }:

{

  options.mymodules.networking.enable = lib.mkEnableOption "networking";

  config = lib.mkIf config.mymodules.networking.enable {

    # Enable networking
    networking.networkmanager.enable = true;

  };

}
