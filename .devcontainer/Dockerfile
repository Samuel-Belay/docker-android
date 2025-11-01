FROM ubuntu:22.04

# --- Install dependencies ---
RUN apt-get update && apt-get install -y \
    wget unzip curl git openjdk-11-jdk python3 python3-pip \
    xfce4 xfce4-session x11vnc xvfb socat lsof net-tools sudo \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# --- Add a user ---
RUN groupadd --gid 1000 vscode \
 && useradd -m -s /bin/bash --uid 1000 --gid 1000 vscode \
 && echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER vscode
WORKDIR /home/vscode

# --- Copy scripts ---
COPY scripts /home/vscode/scripts
RUN chmod +x /home/vscode/scripts/*.sh

# --- Android SDK setup ---
RUN /home/vscode/scripts/download-sdk.sh
RUN /home/vscode/scripts/start-android.sh
