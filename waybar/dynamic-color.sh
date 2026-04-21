#!/bin/bash
# ✦ Gehenna — waybar/dynamic-color.sh
# ──────────────────────────────────────
# Extracts the primary color from the current wallpaper and patches waybar's
# style.css, then sends SIGHUP to reload the bar.

CURRENT_WALLPAPER=$(waypaper --current)

if [[ -n "$CURRENT_WALLPAPER" && -f "$CURRENT_WALLPAPER" ]]; then
  COLOR=$(convert "$CURRENT_WALLPAPER" -format "%[color:primary]" info:)
  COLOR=$(echo "$COLOR" | awk '{print $1}')

  sed -i "s/#c8e0ee/$COLOR/" "$HOME/.config/waybar/style.css"
  sed -i "s/#3a6080/$COLOR/" "$HOME/.config/waybar/style.css"
  sed -i "s/#7eb8d4/$COLOR/" "$HOME/.config/waybar/style.css"

  kill -HUP "$(pgrep waybar)"
fi
