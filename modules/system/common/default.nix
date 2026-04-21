{ config, pkgs, lib, ... }:

let
  user = config.mymodules.mainUser;
in

{

  options.mymodules.common.enable = lib.mkEnableOption "common packages";

  config = lib.mkIf config.mymodules.common.enable {

    environment.systemPackages = with pkgs; [
      bat
      tree
      pciutils 
      btop 
      unzip 
      git 
      p7zip 
      wget
      killall 
    ];

    # Experimental Features
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    # Enable terminal info
    environment.enableAllTerminfo = true;

    # Set your time zone.
    time.timeZone = "Europe/Brussels";

    # Select internationalisation properties.
    i18n.defaultLocale = "nl_BE.UTF-8";
    
    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "be";
      variant = "";
    };
    
    # Configure console keymap
    console.keyMap = "be-latin1";

    # Create config folder with proper permissions 
    systemd.tmpfiles.rules = [
      "d /home/${user}/.config 0755 ${user} users - -"
    ];

  };

}
