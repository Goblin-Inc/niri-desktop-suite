#!/bin/bash

# 2. Теперь мгновенно запускаем весь графический интерфейс в фоновом режиме
swaync &
pkill swaybg; swaybg -m fill -i $HOME/.config/i3/wallpapers/RP1.png &
python3 -m http.server 1225 --directory $HOME/.config/bin/dashboard &
python3 -m $HOME/.config/niri/bin/niri-session.py
python3 -m $HOME/.config/niri/bin/niri-power-sync.py
pkill swayidle; swayidle -w

# 1. Сначала строго по очереди настраиваем окружение
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=niri
systemctl --user restart xdg-desktop-portal
