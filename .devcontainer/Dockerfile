# ---------- Base ----------
FROM ubuntu:22.04

# ---------- Environment ----------
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/London
ENV ANDROID_SDK_ROOT=/opt/android-sdk
ENV PATH=$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$PATH

# ---------- Create user ----------
RUN groupadd --gid 1000 vscode \
    && useradd -m -s /bin/bash --uid 1000 --gid 1000 vscode \
    && apt-get update && apt-get install -y sudo \
    && echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER vscode
WORKDIR /home/vscode

# ---------- Install packages ----------
RUN sudo apt-get update && sudo apt-get install -y \
    wget unzip curl git openjdk-11-jdk python3 python3-pip \
    xfce4 xfce4-session x11vnc xvfb socat lsof net-tools \
    && sudo apt-get clean && rm -rf /var/lib/apt/lists/*

# ---------- Install Android SDK ----------
RUN mkdir -p $ANDROID_SDK_ROOT/cmdline-tools/latest \
    && wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O cmdline-tools.zip \
    && unzip cmdline-tools.zip -d $ANDROID_SDK_ROOT/cmdline-tools/latest \
    && rm cmdline-tools.zip

# ---------- Accept licenses ----------
RUN yes | $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager --licenses

# ---------- Install SDK components ----------
RUN $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager \
    "platform-tools" \
    "platforms;android-33" \
    "system-images;android-33;google_apis_playstore;x86_64" \
    "emulator"

# ---------- Create AVD ----------
RUN mkdir -p /home/vscode/.android/avd \
    && echo "no" | $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/avdmanager create avd -n pixel6 -k "system-images;android-33;google_apis_playstore;x86_64" -d "pixel_6"

# ---------- Copy start script ----------
COPY start-android.sh /usr/local/bin/start-android.sh
RUN chmod +x /usr/local/bin/start-android.sh
