#!/bin/bash

# Папка с обоями
WALL_DIR="$HOME/.config/i3/wallpapers"

# Проверка существования директории
if [ ! -d "$WALL_DIR" ]; then
    notify-send "Ошибка обоев" "Папка $WALL_DIR не найдена"
    exit 1
fi

# Выбор обоев через Fuzzel (поддерживаются png, jpg, jpeg, webp)
SELECTED=$(ls "$WALL_DIR" | grep -E '\.(png|jpg|jpeg|webp)$' | fuzzel --dmenu --prompt="🖼️  Обои: " -w 30 -l 10)

if [ -n "$SELECTED" ]; then
    pkill swaybg
    swaybg -m fill -i "$WALL_DIR/$SELECTED" &
    notify-send "Niri Wallpaper" "Обои успешно изменены на: $SELECTED"
fi
