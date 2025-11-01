# ---------- Base image ----------
FROM ubuntu:22.04

# ---------- Environment ----------
ENV DEBIAN_FRONTEND=noninteractive
ENV ANDROID_SDK_ROOT=/home/vscode/android-sdk
ENV PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/emulator

# ---------- Create user ----------
RUN groupadd --gid 1000 vscode \
    && useradd -m -s /bin/bash --uid 1000 --gid 1000 vscode \
    && echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

WORKDIR /home/vscode

# ---------- Install dependencies ----------
RUN apt-get update && apt-get install -y \
    wget unzip curl git sudo \
    openjdk-11-jdk python3 python3-pip \
    xfce4 xfce4-session x11vnc xvfb socat lsof net-tools \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# ---------- Create scripts folder ----------
COPY scripts /scripts
RUN chmod +x /scripts/*.sh

# ---------- Download Android command-line tools ----------
RUN mkdir -p $ANDROID_SDK_ROOT/cmdline-tools/latest \
    && wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O cmdline-tools.zip \
    && unzip cmdline-tools.zip -d $ANDROID_SDK_ROOT/cmdline-tools/latest \
    && rm cmdline-tools.zip

# ---------- Accept SDK licenses ----------
RUN yes | $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager --licenses

# ---------- Install SDK packages ----------
RUN $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager \
    "platform-tools" \
    "platforms;android-33" \
    "system-images;android-33;google_apis_playstore;x86_64" \
    "emulator" \
    && rm -rf $ANDROID_SDK_ROOT/.android/cache

# ---------- Create AVD ----------
RUN mkdir -p /home/vscode/.android/avd \
    && echo "no" | $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/avdmanager create avd \
    -n pixel6 -k "system-images;android-33;google_apis_playstore;x86_64" -d "pixel_6"

# ---------- Copy startup script ----------
COPY start-android.sh /usr/local/bin/start-android.sh
RUN chmod +x /usr/local/bin/start-android.sh

# ---------- Set user ----------
USER vscode
WORKDIR /home/vscode

# ---------- Default command ----------
CMD ["/usr/local/bin/start-android.sh"]
