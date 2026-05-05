{ config, pkgs, lib, ... }:

{

  options = {
    mymodules.alacritty.enable = 
      lib.mkEnableOption "alacritty terminal";
  };

  config = 
    lib.mkIf config.mymodules.alacritty.enable {

    environment.systemPackages = with pkgs; [
      alacritty
    ];

  };

}
