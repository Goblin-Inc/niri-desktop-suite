# Niri Wayland Desktop Suite

> 🌐 **Language:** **English** | [Русский (README_Ru.md)](README_Ru.md)

A collection of custom scripts, background IPC daemons (Python/Bash), and configurations for the **Niri** scrollable-tiling Wayland compositor, **Waybar**, **Fuzzel** launcher, and **Kitty** terminal.

## ✨ Components & Features

### 🧠 Background Daemons & IPC Scripts (`niri/bin/`)
- **`niri-session.py`** — session manager for Niri: saves the list of open applications, their `workspace_id`, and `is_floating` state via JSON IPC (`niri msg -j windows`), automatically restoring your session on startup.
- **`niri-power-sync.py`** — background power-state daemon: monitors transitions between AC power and battery, automatically switching `powerprofilesctl` profiles (`balanced` / `power-saver`), screen brightness (`brightnessctl`), and sending desktop notifications.

### ⚡ Interactive Fuzzel-Based Wayland Applets (`niri/bin/`)
- **`qr-tool.sh`** — captures a selected screen region (`grim` + `slurp`), decodes QR codes (`zbarimg`) into the clipboard (`wl-copy`), or generates a QR code from the current clipboard (`qrencode`).
- **`wifi-menu.sh`** — scans and connects to Wi-Fi networks using `nmcli` and `fuzzel` (including `--password` prompt support).
- **`battery-menu.sh`** — displays battery charge/status and provides quick switching between power profiles (`Power-Saver`, `Balanced`, `Performance`) and screen brightness levels.
- **`media-menu.sh`** — controls active media players via `playerctl` (play/pause, track skipping, current artist/title display).
- **`volume-menu.sh`** — manages PipeWire audio volume (`wpctl`) with quick access to `pavucontrol`.
- **`clipmenu.sh`** — Wayland clipboard history manager (`cliphist` + `fuzzel` + `wl-copy`).
- **`calc-menu.sh`** — interactive Fuzzel calculator (`bc`) that copies results directly to the clipboard.
- **`calendar-popup.sh`** — desktop notification calendar popup highlighting the current day.
- **`wallpaper-select.sh`** — interactive wallpaper picker and switcher (`swaybg`).
- **`powermenu.sh`** — session lock (`swaylock`), suspend, logout from Niri, reboot, and poweroff menu.

### 🎨 Environment Configurations
- **`niri/`** — compositor configuration (`config.kdl`) and startup script (`autostart.sh`).
- **`waybar/`** — vertical sidebar layout (`config.jsonc`, `style.css`) integrated with Niri workspaces, MPD music status, and system indicators.
- **`fuzzel/`** — application launcher configuration (`fuzzel.ini` styled with the Catppuccin Mocha palette).
- **`kitty/`** — terminal emulator configuration (`kitty.conf`).

## 🚀 Installation

```bash
cp -r niri waybar fuzzel kitty ~/.config/
chmod +x ~/.config/niri/bin/* ~/.config/niri/autostart.sh
```

## 📄 License
MIT © [Goblin-Inc](https://github.com/Goblin-Inc)
