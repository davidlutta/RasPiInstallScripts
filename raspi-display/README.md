# Raspberry Pi Setup Scripts

A collection of useful scripts and configuration files to help me quickly set up my Raspberry Pi as a MagicMirror touchscreen kiosk with smart display control.

---

## 📁 Scripts

### 🖱️ `toggle-display.py`

Listens for touchscreen input and toggles the screen on/off using `vcgencmd`. Debounced to avoid flicker. Defaults to the official Pi display ("raspberrypi-ts").

### 🛠️ Autostart Files

Place `.desktop` entries in:
```
~/.config/autostart/
```

To ensure both scripts run at login.

---

## 🕐 Scheduled Screen On/Off

Edit `crontab -e` and add:

```cron
# Turn screen OFF at 10:30 PM
30 22 * * * /usr/bin/vcgencmd display_power 0

# Turn screen ON at 7:00 AM
0 7 * * * /usr/bin/vcgencmd display_power 1
```

### 🔧 Requirements
```bash
sudo apt update
sudo apt install -y chromium-browser unclutter python3-evdev
```

Make sure you're using the vc4-fkms-v3d overlay in /boot/firmware/config.txt:
```
dtoverlay=vc4-fkms-v3d-pi4
```