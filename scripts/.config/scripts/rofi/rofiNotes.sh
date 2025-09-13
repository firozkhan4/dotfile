#!/usr/bin/env bash

TERMINAL=${TERMINAL:-kitty}
dir="$HOME/Notes"
theme="$HOME/.config/scripts/rofi/rofiBooks.rasi"

if [ ! -d "$dir" ]; then
  mkdir -p "$dir"
  notify-send "Notes directory created"
fi

cd "$dir" || exit

new_note() {
  notify-send "Creating new note"
  local FILENAME
  if [ "$1" = "New note" ]; then
    FILENAME=$(date +"%Y-%m-%d-%H-%M-%S")
  else
    FILENAME="$1"
  fi
  "$TERMINAL" -e nvim "$FILENAME".md
}

FILES=()
FILES+=("New note")
while IFS= read -r file; do
  FILES+=("$file")
done < <(find "$dir" -type f -exec basename {} \;)

SELECTED_FILE=$(printf "%s\n" "${FILES[@]}" | rofi -dmenu -i -l 10 -theme "$theme" -p "Select note: " )

if [ -n "$SELECTED_FILE" ]; then
  notify-send "Opening: $SELECTED_FILE"

  if [ "$SELECTED_FILE" = "New note" ]; then
    new_note "$SELECTED_FILE"
    exit 0
  fi

  FOUND=0
  for file in "${FILES[@]}"; do
    if [ "$file" = "$SELECTED_FILE" ]; then
      FOUND=1
      break
    fi
  done

  if [ "$FOUND" -eq 1 ]; then
    "$TERMINAL" -e nvim "$SELECTED_FILE"
  else
    new_note "$SELECTED_FILE"
  fi
else
  notify-send "No note selected"
fi

