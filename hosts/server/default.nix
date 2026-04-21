{ config, pkgs, lib, ... }:

{

  imports = [
    ./hardware-configuration.nix
    ../../users/simon
    ../../profiles/optiplex
  ];

  # KernelPackages
  boot.kernelPackages = pkgs.linuxPackages;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # SSH
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = false;
    };
  };

  # Hostname
  networking = {
    hostName = "optiplex";
    useDHCP = false;
    interfaces.enp2s0 = {
      useDHCP = false;
      ipv4.addresses = [{
        address  = "192.168.0.44";
        prefixLength = 24;
      }];
    };
    defaultGateway  = "192.168.0.1";
    nameservers     = [ "195.130.130.130" "195.130.130.4" ];
    firewall.enable = true;
    firewall.allowedTCPPorts = [ 22 ];
  };

  # system stateVersion
  system.stateVersion = "25.11";

  # Bootloader
  boot.loader = {
    systemd-boot.enable             = true;
    systemd-boot.configurationLimit = 1;
    efi.canTouchEfiVariables        = true;
  };
}
