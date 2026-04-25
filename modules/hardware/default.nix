{ config, pkgs, lib, ... }:

{

  imports = [
    ./input
    ./lenovo-legion
    ./gpu/nvidia/nvidia-laptop
    ./power-management
    ./printing
    ./sensors
    ./sound
  ];

}
