#!/bin/bash

export ANDROID_SDK_ROOT=/opt/android-sdk
export PATH=$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$PATH

# Start virtual framebuffer
Xvfb :1 -screen 0 1920x1080x24 &
export DISPLAY=:1

# Start VNC server
x11vnc -display :1 -forever -shared -nopw &

# Start emulator
emulator -avd pixel6 -no-snapshot-load -no-boot-anim -gpu swiftshader_indirect &
