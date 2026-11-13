#!/bin/bash

# Вызов меню Fuzzel
CHOSEN=$(printf "🔊 Громкость 100%%\n🔊 Громкость 75%%\n🔊 Громкость 50%%\n🔊 Громкость 25%%\n🔇 Вкл / Выкл звук (Mute)\n🎛️  Открыть полный микшер (Pavucontrol)" | fuzzel --dmenu --prompt="🔊 Звук: " -w 32 -l 6)

case "$CHOSEN" in
    *"100%"*) wpctl set-volume @DEFAULT_AUDIO_SINK@ 1.0 ;;
    *"75%"*)  wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.75 ;;
    *"50%"*)  wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.50 ;;
    *"25%"*)  wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.25 ;;
    *"Mute"*) wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ;;
    *"Pavucontrol"*) pavucontrol & ;;
esac
