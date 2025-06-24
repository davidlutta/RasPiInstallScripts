#!/usr/bin/env python3

from evdev import InputDevice, categorize, ecodes, list_devices
import subprocess
import time

TOUCH_DEVICE_NAME = "raspberrypi-ts"  # <-- Your current device
COOLDOWN_SECONDS = 2  # Prevent rapid toggles

def get_display_status():
    result = subprocess.run(["vcgencmd", "display_power"], capture_output=True, text=True)
    return "1" in result.stdout

def toggle_display(state):
    subprocess.run(["vcgencmd", "display_power", "1" if state else "0"])

def find_touch_device():
    for dev_path in list_devices():
        dev = InputDevice(dev_path)
        if TOUCH_DEVICE_NAME in dev.name:
            return dev
    return None

def main():
    dev = find_touch_device()
    if not dev:
        print("Touchscreen device not found.")
        return

    print(f"Listening for input on {dev.name}")
    last_toggle_time = 0

    for event in dev.read_loop():
        if event.type == ecodes.EV_KEY or event.type == ecodes.EV_ABS:
            now = time.time()
            if now - last_toggle_time >= COOLDOWN_SECONDS:
                current = get_display_status()
                toggle_display(not current)
                last_toggle_time = now

if __name__ == "__main__":
    main()
