#!/bin/bash

# Получаем текущий статус и трек
STATUS=$(playerctl status 2>/dev/null || echo "Ничего не играет")
ARTIST=$(playerctl metadata artist 2>/dev/null)
TITLE=$(playerctl metadata title 2>/dev/null)

NOW_PLAYING="Плеер не активен"
if [ -n "$TITLE" ]; then
    NOW_PLAYING="$ARTIST — $TITLE"
fi

# Меню управления
CHOSEN=$(printf "⏯️  Пауза / Воспроизведение\n⏭️  Следующий трек\n⏮️  Предыдущий трек\nℹ️  Информация о треке" | fuzzel --dmenu --prompt="🎵 [$STATUS] $NOW_PLAYING: " -w 50 -l 4)

case "$CHOSEN" in
    *"Пауза"*) playerctl play-pause ;;
    *"Следующий"*) playerctl next ;;
    *"Предыдущий"*) playerctl previous ;;
    *"Информация"*) notify-send "🎵 Сейчас играет" "$NOW_PLAYING" ;;
esac
