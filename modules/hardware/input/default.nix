{ config, pkgs, lib, ... }:

{

  options.mymodules.input.enable = lib.mkEnableOption "input";

  config = lib.mkIf config.mymodules.input.enable {
    environment.systemPackages = with pkgs; [
      brightnessctl
      libinput
      piper
    ];

    services.ratbagd.enable = true;

  };

}
