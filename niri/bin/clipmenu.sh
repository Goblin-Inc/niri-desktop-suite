#!/bin/bash

# Получаем историю из cliphist и выводим в fuzzel
cliphist list | fuzzel --dmenu --prompt="📋 Буфер: " -w 60 -l 10 | cliphist decode | wl-copy
