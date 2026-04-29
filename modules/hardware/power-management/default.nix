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
        # CPU governor
        CPU_SCALING_GOVERNOR_ON_BAT   = "schedutil";
        CPU_SCALING_GOVERNOR_ON_AC    = "schedutil";

        # Energy/Performance Policy
        # Intel: HWP EPP hints. AMD: amd_pstate EPP. Same value names work on both.
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC  = "performance";

        # Turbo boost
        CPU_BOOST_ON_BAT              = 1;
        CPU_BOOST_ON_AC               = 1;

        # Intel HWP dynamic boost (ignored on AMD, safe to leave)
        CPU_HWP_DYN_BOOST_ON_BAT      = 0;
        CPU_HWP_DYN_BOOST_ON_AC       = 1;

        # Platform profile
        PLATFORM_PROFILE_ON_BAT       = "low-power";
        PLATFORM_PROFILE_ON_AC        = "balanced";

        # Runtime PM
        RUNTIME_PM_ON_BAT             = "auto";
        RUNTIME_PM_ON_AC              = "on";

        # Disk
        DISK_IOSCHEDULER_ON_BAT       = "mq-deadline";

        # WiFi
        WIFI_PWR_ON_BAT               = "on";
        WIFI_PWR_ON_AC                = "off";

        # Charging threshold
        START_CHARGE_THRESH_BAT0 = 95;
        STOP_CHARGE_THRESH_BAT0  = 100;

        # USB
        USB_AUTOSUSPEND               = 0;
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
