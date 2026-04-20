{ config, pkgs, lib, ... }:

{

  options.mymodules.printing.enable = lib.mkEnableOption "printing";

  config = lib.mkIf config.mymodules.printing.enable {

      # Printing
    services.printing.enable = true;

    # Avahi — mDNS / .local resolution & printer discovery
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    # Printing drivers/services
    services.printing.drivers = with pkgs; [
      gutenprint
      gutenprintBin      # binary blobs for some Epson/Canon
      #hplip              # HP printers
      #brlaser            # Brother laser printers
      epson-escpr        # Epson inkjet
      cups-filters
    ];

    # Driverless scanning
    hardware.sane = {
      enable = true;
      extraBackends = [
        pkgs.sane-airscan
      ];
    };

  };
    
}
