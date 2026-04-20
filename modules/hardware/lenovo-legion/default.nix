{ config, pkgs, lib, ... }:

{
  options.mymodules.lenovo-legion.enable = lib.mkEnableOption "lenovo-legion";

  config = lib.mkIf config.mymodules.lenovo-legion.enable {

    boot.extraModulePackages = [
      config.boot.kernelPackages.lenovo-legion-module
    ];

    boot.kernelModules = [ "legion_laptop" ];

    environment.systemPackages = with pkgs; [
      lenovo-legion
    ];

  };
}
