#!/usr/bin/env python3
import sys
import json
import subprocess
import time
import os

SESSION_FILE = os.path.expanduser("~/.config/niri/saved_session.json")

def save_session():
    windows = json.loads(subprocess.check_output(["niri", "msg", "-j", "windows"]))
    session_data = []

    for w in windows:
        if w.get("app_id"):
            session_data.append({
                "app_id": w["app_id"],
                "workspace_id": w.get("workspace_id"),
                "is_floating": w.get("is_floating", False)
            })

    with open(SESSION_FILE, "w") as f:
        json.dump(session_data, f, indent=2)

    subprocess.run(["notify-send", "💾 Сессия Niri", f"Сохранено {len(session_data)} окон"])

def restore_session():
    if not os.path.exists(SESSION_FILE):
        subprocess.run(["notify-send", "⚠️ Сессия Niri", "Сохраненный файл сессии не найден"])
        return

    with open(SESSION_FILE, "r") as f:
        session_data = json.load(f)

    for item in session_data:
        app = item["app_id"]
        # Запускаем приложение в фоновом режиме
        subprocess.Popen([app], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        time.sleep(0.3)

    subprocess.run(["notify-send", "🚀 Сессия Niri", "Все приложения восстановлены"])

if __name__ == "__main__":
    if len(sys.argv) > 1 and sys.argv[1] == "restore":
        restore_session()
    else:
        save_session()
