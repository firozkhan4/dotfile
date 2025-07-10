#!/usr/bin/env bash


rofi_theme="$HOME/.config/scripts/rofi/rofiBooks.rasi"
SELECT=$(echo -e "5\n15\n25" | rofi -dmenu -p "Minutes: " -theme "$rofi_theme")


if [ -z "$SELECT" ]; then
  exit 1
fi

SELECTm=$((SELECT * 60))

notify-send -u normal "Timer Started for $SELECT minutes"
sleep $SELECTm && notify-send -u normal "Timer Done" && paplay /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga
