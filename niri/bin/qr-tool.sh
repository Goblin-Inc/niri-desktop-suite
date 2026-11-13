#!/bin/bash

ACTION=$(printf "📷 Считать QR с экрана\n📱 Создать QR из буфера" | fuzzel --dmenu --prompt="📲 QR Tool: " -w 30 -l 2)

TEMP_IMG="/tmp/qr_code.png"

case "$ACTION" in
    *"Считать"*)
        grim -g "$(slurp)" "$TEMP_IMG" 2>/dev/null
        if [ -f "$TEMP_IMG" ]; then
            TEXT=$(zbarimg --raw -q "$TEMP_IMG")
            rm -f "$TEMP_IMG"
            if [ -n "$TEXT" ]; then
                echo -n "$TEXT" | wl-copy
                notify-send "📲 QR считан" "$TEXT\n\n(Скопировано в буфер)"
            else
                notify-send "📲 Ошибка" "QR-код не обнаружен"
            fi
        fi
        ;;
    *"Создать"*)
        CLIP_TEXT=$(wl-paste)
        if [ -n "$CLIP_TEXT" ]; then
            qrencode -o "$TEMP_IMG" -s 8 "$CLIP_TEXT"
            swayimg "$TEMP_IMG" &
            notify-send "📲 QR создан" "Показан текст из буфера обмена"
        else
            notify-send "📲 Ошибка" "Буфер обмена пуст"
        fi
        ;;
esac
