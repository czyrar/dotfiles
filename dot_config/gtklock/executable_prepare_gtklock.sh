#!/bin/sh

style_file="$HOME/.config/gtklock/style.css"
[ -f "$style_file" ] && rm "$style_file" || touch "$style_file"

# Background
cache_dict="$HOME/.config/gtklock/.cache"
[ -d "$cache_dict" ] || mkdir -p "$cache_dict"
query=$(swww query | cut -d' ' -f2,9)
echo "$query" | while IFS= read -r wallpaper_info; do
  output=$(printf "%s" "$wallpaper_info" | cut -d' ' -f1)
  wallpaper=$(printf "%s" "$wallpaper_info" | cut -d' ' -f2)
  lockpaper="$cache_dict/$(basename $wallpaper)"
  [ -f "$lockpaper" ] || magick "$wallpaper" -filter Gaussian -resize 2.5% -define filter:sigma=2.5 -resize 4000% "$lockpaper"
  echo "window#${output%?} {" >> "$style_file"
  echo "  background-image: url(\"$lockpaper\");" >> "$style_file"
  echo "}" >> "$style_file"
done

cat << EOF >> "$style_file"
#window-box {
  padding: 64px;
  border: 1px solid #BB9AF7;
  background-color: #1A1B26;
}
EOF
