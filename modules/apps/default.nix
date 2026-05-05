{ config, pkgs, lib, ... }:

{

  imports = [
    ./alacritty
    ./chromium
    ./docker
    ./firefox
    ./gamemode
    ./gimp
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
    ./emulators
  ];

}
