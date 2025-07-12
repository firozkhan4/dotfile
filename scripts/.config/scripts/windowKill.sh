#!/usr/bin/env bash


pids=$(hyprctl clients | awk '/pid:/ {printf "PID: %s\n", $2}')

touch /home/firoz/Notes/test

for pid in $pids; do
  kill -9 $pid
done
