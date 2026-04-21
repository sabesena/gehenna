#!/bin/bash
# ✦ Gehenna — waybar/scripts/gpu.sh
# ────────────────────────────────────
# NVIDIA GPU utilization for waybar custom/gpu module.

gpu=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null)

if [ -z "$gpu" ]; then
  echo "N/A"
else
  echo "${gpu}%"
fi
