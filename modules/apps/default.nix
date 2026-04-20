{ config, pkgs, lib, ... }:

{

  imports = [
    ./browsers
#    ./cli-tools
    ./editors
    ./file-browsers
    ./gaming
    ./media
    ./office
    ./terminals
  ];

}
