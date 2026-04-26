{ config, pkgs, lib, ... }:

{

  imports = [
    ./hardware-configuration.nix
    ../../users/simon
    ../../profiles/thinkpad
  ];

  # KernelPackages
  boot.kernelPackages = pkgs.linuxPackages;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Hostname
  networking.hostName = "thinkpad";

  # system stateVersion
  system.stateVersion = "25.11";

  # Bootloader
  boot.loader = {
    systemd-boot.enable             = true;
    systemd-boot.configurationLimit = 1;
    efi.canTouchEfiVariables        = true;
  };

}
