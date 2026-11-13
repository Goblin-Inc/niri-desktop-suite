#!/bin/bash

# Поиск батареи в системе
BAT_PATH="/sys/class/power_supply/BAT0"
[ ! -d "$BAT_PATH" ] && BAT_PATH="/sys/class/power_supply/BAT1"

CAPACITY=$(cat "$BAT_PATH/capacity" 2>/dev/null || echo "100")
STATUS=$(cat "$BAT_PATH/status" 2>/dev/null || echo "AC")
CURRENT_PROFILE=$(powerprofilesctl get 2>/dev/null || echo "balanced")

# Формируем меню
CHOSEN=$(printf "🌱 Режим: Power-Saver\n⚖️  Режим: Balanced\n⚡ Режим: Performance\n🔆 Яркость: 100%%\n🔆 Яркость: 50%%\n🔆 Яркость: 20%%" | fuzzel --dmenu --prompt="🔋 [$CAPACITY% | $STATUS | $CURRENT_PROFILE]: " -w 45 -l 6)

case "$CHOSEN" in
    *"Power-Saver"*) powerprofilesctl set power-saver && notify-send "🌱 Питание" "Включен режим Энергосбережения" ;;
    *"Balanced"*)    powerprofilesctl set balanced && notify-send "⚖️ Питание" "Включен Сбалансированный режим" ;;
    *"Performance"*) powerprofilesctl set performance && notify-send "⚡ Питание" "Включен Режим Максимальной Производительности" ;;
    *"100%"*) brightnessctl set 100% ;;
    *"50%"*)  brightnessctl set 50% ;;
    *"20%"*)  brightnessctl set 20% ;;
esac
