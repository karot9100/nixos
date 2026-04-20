{ config, pkgs, lib, ... }:

{

  options.mymodules.kitty.enable = lib.mkEnableOption "kitty";

  config = lib.mkIf config.mymodules.kitty.enable {

    environment.systemPackages = with pkgs; [
     kitty 
    ];

  };

}
