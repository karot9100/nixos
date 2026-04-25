{ config, pkgs, lib, ... }:

{

  imports = [
    ./networking
    ./bash
    ./common
    ./dotfiles
    ./theme
    ./keyring
    ./main-user
    ./smb-share
    ./boot-animation
  ];

}
