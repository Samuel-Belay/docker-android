#!/bin/bash
# ---------- Start virtual display ----------
XVFB_DISPLAY=:1
Xvfb $XVFB_DISPLAY -screen 0 1920x1080x24 &
export DISPLAY=$XVFB_DISPLAY

# ---------- Start VNC server ----------
x11vnc -display $DISPLAY -forever -nopw -shared &

# ---------- Start Android Emulator ----------
$ANDROID_SDK_ROOT/emulator/emulator -avd pixel6 -no-snapshot-load -no-audio -gpu swiftshader_indirect -netdelay none -netspeed full &

# ---------- Keep container running ----------
wait
