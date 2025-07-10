#!/usr/bin/env bash

rofi_theme="$HOME/dotfile/scripts/.config/scripts/rofi/rofiProcess.rasi"

process=$(ps -eo pid,comm)

SELECT=$(echo "$process" | rofi -dmenu -i -p "Process" -theme "$rofi_theme")
PID=$(echo "$SELECT" | awk '{print $1}')

if [ -n "$SELECT" ]; then
  notify-send "Killing process" "$SELECT"
  kill "$PID"
fi
