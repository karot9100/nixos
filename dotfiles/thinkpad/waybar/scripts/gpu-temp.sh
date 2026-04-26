#!/usr/bin/env bash

COLOR_CPU="#66ccff"   # light blue

# AMD Ryzen reports CPU package temp via the k10temp sensor as "Tctl"
# (or "Tdie" on some kernels). Both work — this picks whichever appears first.
TEMP=$(sensors | awk '/^(Tctl|Tdie):/ {gsub(/\+|°C/,"",$2); print $2; exit}')

# Fallback if neither label exists
if [[ -z "$TEMP" ]]; then
    TEMP=$(sensors | grep -m1 'Core 0' | awk '{print $3}' | tr -d '+°C')
fi

echo "{\"text\": \"${TEMP}°C\", \"class\": \"cpu\", \"color\": \"${COLOR_CPU}\"}"
