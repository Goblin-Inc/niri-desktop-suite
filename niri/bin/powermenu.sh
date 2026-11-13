#!/bin/bash

# Опции меню
SELECTION=$(printf "🔒 Заблокировать\n💤 Сон (Suspend)\n🚪 Выйти из Niri\n🔄 Перезагрузить\n Выключить" | fuzzel --dmenu --prompt="⚡ Питание: " -w 25 -l 5)

case "$SELECTION" in
    *"Заблокировать"*)
        swaylock -f -c 000000 || notify-send "Ошибка" "Утилита swaylock не установлена"
        ;;
    *"Сон"*)
        systemctl suspend
        ;;
    *"Выйти из Niri"*)
        niri msg action quit
        ;;
    *"Перезагрузить"*)
        systemctl reboot
        ;;
    *"Выключить"*)
        systemctl poweroff
        ;;
esac

