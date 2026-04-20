{ config, pkgs, lib, ... }:

{

  imports = [
    ./hardware-configuration.nix
    ../../users/simon
    ../../profiles/laptop-simon
  ];

  # KernelPackages
  boot.kernelPackages = pkgs.linuxPackages;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # system stateVersion
  system.stateVersion = "25.11";

  # Bootloader
  boot.loader = {
    systemd-boot.enable             = true;
    systemd-boot.configurationLimit = 1;
    efi.canTouchEfiVariables        = true;
  };

  # Mount second ssd
  fileSystems."/mnt/1tb-ssd" = {
    device  = "/dev/disk/by-uuid/489df8ee-3bd1-4f41-80af-d0245509aac4";
    fsType  = "ext4";
    options = [ "defaults" "nofail" ];
  };

}
