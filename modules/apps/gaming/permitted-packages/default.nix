{ config, pkgs, lib, ... }:

{

  options.mymodules.perm-pkgs.enable = lib.mkEnableOption "perm-pkgs";

  config = lib.mkIf config.mymodules.perm-pkgs.enable {
      
    nixpkgs.config.permittedInsecurePackages = [
      
      # Lutris
      "mbedtls-2.28.10"
      
      # Needed for RS3 in Bolt launcher
      "openssl-1.1.1w"
    ];

  };

}

