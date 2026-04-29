{ config, pkgs, lib, ... }:

{

  options.mymodules.thunderbird.enable = lib.mkEnableOption "thunderbird";

  config = lib.mkIf config.mymodules.thunderbird.enable {

    programs.thunderbird = {
      enable = true;
    };

  };

}
