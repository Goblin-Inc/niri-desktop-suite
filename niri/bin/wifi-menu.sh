#!/bin/bash

# Сканируем доступные сети
NETWORKS=$(nmcli -t -f SSID,SECURITY,SIGNAL dev wifi list | grep -v '^--' | sort -u)

if [ -z "$NETWORKS" ]; then
    notify-send "Wi-Fi" "Доступные сети не найдены"
    exit 0
fi

# Выводим список в Fuzzel
CHOSEN=$(echo "$NETWORKS" | awk -F: '{print $1 " (" $2 ", " $3 "%)"}' | fuzzel --dmenu --prompt="📶 Wi-Fi: " -w 35 -l 8)

if [ -n "$CHOSEN" ]; then
    SSID=$(echo "$CHOSEN" | sed 's/ (.*//')
    
    # Проверяем, сохранен ли профиль
    if nmcli connection show "$SSID" > /dev/null 2>&1; then
        nmcli dev wifi connect "$SSID" && notify-send "Wi-Fi" "Подключено к $SSID"
    else
        # Ввод пароля в режиме маскировки
        PASS=$(fuzzel --dmenu --prompt="🔑 Пароль для $SSID: " -w 30 -l 0 --password)
        if [ -n "$PASS" ]; then
            nmcli dev wifi connect "$SSID" password "$PASS" && notify-send "Wi-Fi" "Успешное подключение к $SSID" || notify-send "Wi-Fi" "Ошибка подключения"
        fi
    fi
fi
