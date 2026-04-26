{ config, pkgs, lib, ... }:

{

  imports = [
    ./input
    ./lenovo-legion
    ./gpu/nvidia
    ./gpu/amd
    ./cpu/amd
    ./power-management
    ./printing
    ./sensors
    ./sound
  ];

}
