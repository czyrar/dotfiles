#!/bin/sh

swaylock_config="$HOME/.config/swaylock/config"
swaylock_config_template="$HOME/.config/swaylock/config_template"

# Base part
cat "$swaylock_config_template" > "$swaylock_config"

# Background
cache_dict="$HOME/.config/swaylock/.cache"
[ -d "$cache_dict" ] || mkdir -p "$cache_dict"
query=$(swww query | cut -d' ' -f2,9)
echo "$query" | while IFS= read -r wallpaper_info; do
  output=$(printf "%s" "$wallpaper_info" | cut -d' ' -f1)
  wallpaper=$(printf "%s" "$wallpaper_info" | cut -d' ' -f2)
  lockpaper="$cache_dict/$(basename $wallpaper)"
  [ -f "$lockpaper" ] || magick "$wallpaper" -filter Gaussian -resize 2.5% -define filter:sigma=2.5 -resize 4000% "$lockpaper"
  echo "image=$output$lockpaper" >> "$swaylock_config"
done
