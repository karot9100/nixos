{ config, pkgs, lib, ... }:

let
  patchDesktop = pkg: appName: from: to: lib.hiPrio (
    pkgs.runCommand "patched-desktop-entry-for-${appName}" {} ''
      ${pkgs.coreutils}/bin/mkdir -p $out/share/applications
      ${pkgs.gnused}/bin/sed 's#${from}#${to}#g' < ${pkg}/share/applications/${appName}.desktop > $out/share/applications/${appName}.desktop
    '');
  GPUOffloadApp = pkg: desktopName: patchDesktop pkg desktopName "^Exec=" "Exec=nvidia-offload ";
in
  
{

  options.mymodules.nvidia = {
    enable = lib.mkEnableOption "nvidia";
    batterySaver = lib.mkEnableOption "battery saver specialisation";
  };

  config = lib.mkIf config.mymodules.nvidia.enable {
    services.xserver.videoDrivers = [ "intel" "nvidia" ];

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        vulkan-loader
        vulkan-tools
        vulkan-validation-layers
      ];
    };

    hardware.nvidia = {
      open = true;
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = true;
      dynamicBoost.enable = true;
      nvidiaSettings = true;
      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };

    boot.blacklistedKernelModules = [ "nouveau" ];
    boot.kernelParams = [
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    ];

    environment.systemPackages = with pkgs; [
      (GPUOffloadApp steam "steam")
      (GPUOffloadApp (bolt-launcher.override { enableRS3 = true; }) "Bolt")
    ];

    specialisation = lib.mkIf config.mymodules.nvidia.batterySaver {
      battery-saver.configuration = {
        system.nixos.tags = [ "battery-saver" ];
        imports = [ ./nvidia-disable ];
      };
    };

  };

}
