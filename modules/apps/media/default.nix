{ config, pkgs, lib, ... }:

{

  imports = [
    ./video
    ./music
    ./screenshot
    ./player-controls
  ];

}
