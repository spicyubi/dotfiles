#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/blue/"
# CURRENT_WALL=$(hyprctl hyprpaper listloaded)

# Get a random wallpaper that is not the current one
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

# Apply the selected wallpaper
hyprctl hyprpaper preload "$WALLPAPER"
hyprctl hyprpaper reload ,"$WALLPAPER"

# unload inactive wallpapers from memory
hyprctl hyprpaper unload all
