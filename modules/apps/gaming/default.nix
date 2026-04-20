{ config, pkgs, lib, ... }:

{

  imports = [
    ./wine
    ./steam
    ./permitted-packages
    ./gamemode
  ];

}
