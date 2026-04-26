{ lib, config, pkgs, ... }:

{

  options.mymodules.gpu-amd.enable = lib.mkEnableOption "Enable gpu amd";

  config = lib.mkIf config.mymodules.gpu-amd.enable {

    services.xserver.videoDrivers = lib.mkDefault [ "modesetting" ];

    hardware.graphics = {
      enable = lib.mkDefault true;
      enable32Bit = lib.mkDefault true;
    };

    hardware.amdgpu.initrd.enable = lib.mkDefault true;
  };

}
