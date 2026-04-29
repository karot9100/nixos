{ config, pkgs, lib, ... }:

{

  options.mymodules.nautilus.enable = lib.mkEnableOption "nautilus";

  config = lib.mkIf config.mymodules.nautilus.enable {

    environment.systemPackages = with pkgs; [
      nautilus
      nautilus-open-any-terminal
      loupe
    ];

  };

}

