#!/bin/bash

CHOICE=$(echo "lock,suspend,logout,reboot,shutdown" | tr ',' '\n')

SELECTION=$(echo "$CHOICE" | rofi -dmenu -i -p "Power Menu")

case $SELECTION in
  "lock")
    hyprlock
    ;;
  "suspend")
    systemctl suspend
    ;;
  "logout")
    i3-msg exit
    ;;
  "reboot")
    systemctl reboot
    ;;
  "shutdown")
    systemctl poweroff
    ;;
esac
