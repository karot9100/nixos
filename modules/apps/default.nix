{ config, pkgs, lib, ... }:

{

  imports = [
    ./alacritty
    ./chromium
    ./docker
    ./firefox
    ./gamemode
    ./kitty
    ./music
    ./nautilus
    ./permitted-packages
    ./player-controls
    ./screenshot
    ./steam
    ./thunar
    ./thunderbird
    ./video
    ./vim
    ./wine
  ];

}
