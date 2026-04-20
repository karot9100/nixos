{ config, pkgs, lib, ... }:

{

  imports = [
    ./input
    ./lenovo-legion
    ./nvidia/nvidia-laptop
    ./power-management
    ./printing
    ./sensors
    ./sound
  ];

}
