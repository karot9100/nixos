{ config, lib, ... }:

let
  user = config.mymodules.mainUser;
  hostname = config.networking.hostName;
in

{

  options.mymodules.dotfiles.enable = lib.mkEnableOption "dotfiles";

  config = lib.mkIf config.mymodules.dotfiles.enable {

    system.activationScripts.dotfiles = ''
      mkdir -p /home/${user}/.config

      for d in waybar hypr fuzzel swayosd alacritty; do
        if [ -d /etc/nixos/dotfiles/${hostname}/$d ]; then
          rm -rf /home/${user}/.config/$d
          ln -sf /etc/nixos/dotfiles/${hostname}/$d /home/${user}/.config/$d
        fi
      done
    '';

  };

}
