{ config, pkgs, lib, ... }:

{

  options.mymodules.sensors.enable = lib.mkEnableOption "sensors";

  config = lib.mkIf config.mymodules.sensors.enable {

    environment.systemPackages = with pkgs; [
      lm_sensors
      powertop
      mesa-demos
      python3Packages.matplotlib
    ];

  };

}
