#!/usr/bin/env bash

# Colors (Waybar expects hex values)
COLOR_IGPU="#66ccff"     # light blue
COLOR_HYBRID="#ffcc66"   # light orange
COLOR_DGPU="#99ff99"     # light green

# Check if NVIDIA is present
if command -v nvidia-smi &>/dev/null; then
    # Query power draw - used to detect hybrid vs full dGPU usage
    POWER=$(nvidia-smi --query-gpu=power.draw --format=csv,noheader 2>/dev/null)

    # Get NVIDIA temperature
    GPU_TEMP=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader 2>/dev/null)

    if [[ $? -eq 0 ]]; then
        # Hybrid mode: NVIDIA present but idle
        if [[ "$POWER" == "0 W" || "$POWER" == "N/A" ]]; then
            MODE="hybrid"
            COLOR=$COLOR_HYBRID
        else
            MODE="dgpu"
            COLOR=$COLOR_DGPU
        fi

        TEMP="$GPU_TEMP"
    else
        MODE="igpu"
    fi
else
    MODE="igpu"
fi


if [[ "$MODE" == "igpu" ]]; then
    # Intel temp via lm-sensors (adjust if needed)
    TEMP=$(sensors | grep -m1 'Core 0' | awk '{print $3}' | tr -d '+°C')
    COLOR=$COLOR_IGPU
fi

# Output JSON for waybar
echo "{\"text\": \"${TEMP}°C\", \"class\": \"$MODE\", \"color\": \"${COLOR}\"}"

