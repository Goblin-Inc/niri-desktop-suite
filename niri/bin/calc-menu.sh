#!/bin/bash

# Поле ввода выражения
EXPR=$(fuzzel --dmenu --prompt="🧮 Математика: " -w 40 -l 0)

if [ -n "$EXPR" ]; then
    # Считаем с точностью до 4 знаков после запятой
    RESULT=$(echo "scale=4; $EXPR" | bc -l 2>/dev/null)
    
    if [ -n "$RESULT" ]; then
        echo -n "$RESULT" | wl-copy
        notify-send "🧮 Калькулятор" "$EXPR = $RESULT\n\n(Скопировано в буфер)"
    else
        notify-send "🧮 Ошибка" "Некорректное выражение: $EXPR"
    fi
fi
