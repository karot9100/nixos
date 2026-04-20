{ config, pkgs, lib, ... }:

{

  options.mymodules.sound.enable = lib.mkEnableOption "sound";

  config = lib.mkIf config.mymodules.sound.enable {

    # Pipewire
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    security.rtkit.enable = true;

    # Bluetooth
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
    services.upower.enable = true;

    # GUI mixers / bluetooth managers
    environment.systemPackages = with pkgs; [
      pwvucontrol
      overskride
    ];

  };

}

