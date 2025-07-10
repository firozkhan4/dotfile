#!/usr/bin/env bash

dir="$HOME/Documents"
meta_file="$dir/.meta"
rofi_theme="$HOME/.config/scripts/rofi/rofiBooks.rasi"

if [[ ! -d "$dir" ]]; then
  notify-send -u critical "📁 Error" "Directory not found: $dir"
  exit 1
fi

if [[ ! -f "$meta_file" ]]; then
  touch "$meta_file"
fi

last_read=$(grep '^LAST_READ:' "$meta_file" | cut -d ':' -f2- | xargs)

files=$(find "$dir" -maxdepth 1 ! -name ".*" -type f -exec basename {} \;)

if [[ -z "$last_read" ]]; then
  notify-send -u normal "📖 Info" "No previously read file found."
else
  files=$(echo "$files" | grep -vxF "$last_read")
  files=$(echo -e "$last_read\n$files")
  notify-send -u low "📖 Last Read" "$last_read"
fi

SELECT=$(echo "$files" | rofi -dmenu -i -p "Open: " -theme "$rofi_theme")

if [[ -n "$SELECT" ]]; then
  notify-send -u normal "📂 Opening" "$SELECT"
  xdg-open "$dir/$SELECT"

  # Update LAST_READ in .meta file
  if grep -q '^LAST_READ:' "$meta_file"; then
    sed -i "s/^LAST_READ:.*/LAST_READ:$SELECT/" "$meta_file"
  else
    echo "LAST_READ:$SELECT" >> "$meta_file"
  fi
else
  notify-send -u low "❌ Cancelled" "No file selected."
fi

