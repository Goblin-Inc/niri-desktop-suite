#!/usr/bin/env python3
import time
import subprocess
import os

def get_ac_status():
    """Проверяет подключение к сети (True = сеть, False = батарея)"""
    ac_paths = ["/sys/class/power_supply/AC/online", "/sys/class/power_supply/ACAD/online"]
    for path in ac_paths:
        if os.path.exists(path):
            with open(path, "r") as f:
                return f.read().strip() == "1"
    return True

def apply_power_profile(on_ac):
    if on_ac:
        subprocess.run(["powerprofilesctl", "set", "balanced"], stderr=subprocess.DEVNULL)
        subprocess.run(["brightnessctl", "set", "80%"], stderr=subprocess.DEVNULL)
        subprocess.run(["notify-send", "-i", "power-profile-balanced-symbolic", "🔌 Питание от сети", "Режим: Balanced | Яркость: 80%"])
    else:
        subprocess.run(["powerprofilesctl", "set", "power-saver"], stderr=subprocess.DEVNULL)
        subprocess.run(["brightnessctl", "set", "30%"], stderr=subprocess.DEVNULL)
        subprocess.run(["notify-send", "-i", "power-profile-power-saver-symbolic", "🔋 Работа от батареи", "Режим: Power-Saver | Яркость: 30%"])

def main():
    last_state = None
    while True:
        current_state = get_ac_status()
        if current_state != last_state:
            if last_state is not None:
                apply_power_profile(current_state)
            last_state = current_state
        time.sleep(3)

if __name__ == "__main__":
    main()
