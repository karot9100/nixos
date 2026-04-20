#!/usr/bin/env bash
# TLP doesn't have named profiles, so we read the CPU governor as a proxy
governor=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)
case "$governor" in
  performance)
    icon=""
    class="performance"
    ;;
  powersave)
    icon=""
    class="power-saver"
    ;;
  *)
    icon=""
    class="balanced"
    ;;
esac
echo "{\"text\": \"$icon\", \"class\": \"$class\"}"
