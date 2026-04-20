{ config, pkgs, lib, ... }:

{

  imports = [
    ./apps
    ./desktop
    ./system
    ./hardware
  ];

}
