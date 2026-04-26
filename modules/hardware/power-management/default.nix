{ config, pkgs, lib, ... }:

let
  user = config.mymodules.mainUser;
in

{
  options.mymodules.power-management = {
    enable    = lib.mkEnableOption "power-management";
    amdPstate = lib.mkEnableOption "AMD pstate driver (active mode)";
  };

  config = lib.mkIf config.mymodules.power-management.enable {

    boot.kernel.sysctl = {
      "vm.dirty_writeback_centisecs" = 1500;
    };

    # Enable amd_pstate driver in active mode (AMD only)
    boot.kernelParams = lib.mkIf config.mymodules.power-management.amdPstate
      [ "amd_pstate=active" ];

    # Disable PPD — conflicts with TLP
    services.power-profiles-daemon.enable = false;

    services.tlp = {
      enable = true;
      settings = {
        # CPU governor
        CPU_SCALING_GOVERNOR_ON_BAT   = "powersave";
        CPU_SCALING_GOVERNOR_ON_AC    = "performance";

        # Energy/Performance Policy
        # Intel: HWP EPP hints. AMD: amd_pstate EPP. Same value names work on both.
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC  = "performance";

        # Turbo boost
        CPU_BOOST_ON_BAT              = 0;
        CPU_BOOST_ON_AC               = 1;

        # Intel HWP dynamic boost (ignored on AMD, safe to leave)
        CPU_HWP_DYN_BOOST_ON_BAT      = 0;
        CPU_HWP_DYN_BOOST_ON_AC       = 1;

        # Max CPU performance percentage
        CPU_MAX_PERF_ON_BAT           = 50;
        CPU_MAX_PERF_ON_AC            = 100;

        # Platform profile
        PLATFORM_PROFILE_ON_BAT       = "balanced";
        PLATFORM_PROFILE_ON_AC        = "balanced";

        # Runtime PM
        RUNTIME_PM_ON_BAT             = "auto";
        RUNTIME_PM_ON_AC              = "on";

        # Disk
        DISK_IOSCHEDULER_ON_BAT       = "mq-deadline";
        SATA_LINKPWR_ON_BAT           = "med_power_with_dipm";

        # WiFi
        WIFI_PWR_ON_BAT               = "on";
        WIFI_PWR_ON_AC                = "off";

        # Charging threshold
        START_CHARGE_THRESH_BAT0 = 0;
        STOP_CHARGE_THRESH_BAT0  = 100;

        # USB
        USB_AUTOSUSPEND               = 1;
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
