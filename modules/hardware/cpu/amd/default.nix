{ config, lib, pkgs, ... }:

{

  options.mymodules.cpu-amd.enable = lib.mkEnableOption "Enable cpu amd micro code";

  config = lib.mkIf config.mymodules.cpu-amd.enable {

    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    };

}
