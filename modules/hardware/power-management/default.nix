{ config, pkgs, lib, ... }:

let
  user = config.mymodules.mainUser;
in

{
  options.mymodules.power-management.enable = lib.mkEnableOption "power-management";

  config = lib.mkIf config.mymodules.power-management.enable {

    boot.kernel.sysctl = {
      "vm.dirty_writeback_centisecs" = 1500;
    };

    # Disable PPD — conflicts with TLP
    services.power-profiles-daemon.enable = false;

    services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_BAT   = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_BOOST_ON_BAT              = 0;
        CPU_HWP_DYN_BOOST_ON_BAT      = 0;
        CPU_MAX_PERF_ON_BAT           = 50;
        PLATFORM_PROFILE_ON_BAT       = "balanced";
        PLATFORM_PROFILE_ON_AC        = "balanced";
        RUNTIME_PM_ON_BAT             = "auto";
        RUNTIME_PM_ON_AC              = "on";
        DISK_IOSCHEDULER_ON_BAT       = "mq-deadline";
        SATA_LINKPWR_ON_BAT           = "med_power_with_dipm";

        CPU_SCALING_GOVERNOR_ON_AC    = "performance";
        CPU_ENERGY_PERF_POLICY_ON_AC  = "performance";
        CPU_BOOST_ON_AC               = 1;
        CPU_HWP_DYN_BOOST_ON_AC       = 1;

        WIFI_PWR_ON_BAT = "on";
        WIFI_PWR_ON_AC  = "off";

        USB_AUTOSUSPEND = 1;
      };
    };

    security.sudo.extraRules = [
      {
        users = [ user ];
        commands = [
          {
            command = "/run/current-system/sw/bin/tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];

  };
}
