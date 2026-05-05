{ config, pkgs, lib, ... }:

{

  options = {
    mymodules.gimp.enable = 
      lib.mkEnableOption "GIMP";
  };

  config = 
    lib.mkIf config.mymodules.gimp.enable {

    environment.systemPackages = with pkgs; [
      gimp
    ];

  };

}
