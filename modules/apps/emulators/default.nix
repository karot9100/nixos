{ config, pkgs, lib, ... }:

{

  options = {
    mymodules.emulators.enable = 
      lib.mkEnableOption "all the emulators i use";
  };

  config = 
    lib.mkIf config.mymodules.emulators.enable {

    environment.systemPackages = with pkgs; [
     mgba 
    ];

  };

}
